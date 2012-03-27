<?php

class YouTube {
	
	public $typeRequest;
	public $client;
	public $method;
	public $format;
	
	public function __construct() {
		$this->typeRequest = "GET";
		$this->client      = "http://gdata.youtube.com/feeds/api/";
		$this->method  	   = NULL;
		$this->format  	   = "array";
	}
	
	public function query($query = NULL) {
		$this->uri = $query;

		return $this->data();
	}
	
	public function search($search = "", $max = 9, $start = 1) {
		$search = str_replace(" ", "+", trim($search));

		$this->uri = $this->client ."videos/?vq=". $search ."&start-index=". $start ."&max-results=". $max ."&alt=". strtolower($this->format);
		
		return $this->data();
	}
	
	public function getLists($username, $max = 20, $start = 1) {
		$this->uri = $this->client ."users/". trim($username) ."/playlists/?v=2&start-index=". $start ."&max-results=". $max ."&alt=". strtolower($this->format);
		
		return $this->data();
	}
	
	public function getByList($ID = NULL, $max = 9, $start = 1) {
		$this->uri = $this->client ."playlists/". trim($ID) ."/?v=2&start-index=". $start ."&max-results=". $max ."&alt=". strtolower($this->format);
		
		return $this->data();
	}
	
	public function getByUser($username = NULL, $max = 9, $start = 1) {
		$this->uri = $this->client ."users/". trim($username) ."/uploads/?start-index=". $start ."&max-results=". $max ."&hl=es%2DMX" . "&alt=" . strtolower($this->format);
		
		return $this->data();
	}
	
	public function getByID($ID = NULL) {
		$this->uri = $this->client ."videos/". trim($ID) ."?alt=". strtolower($this->format);
		
		return $this->data();
	}
	
	public function data() {
		 try {	 
            $this->results = $this->getResult();
            
            if(!$this->results or is_null($this->results)) {
                return FALSE;
            } else {
                return $this->results;
            }
        } catch (Exception $e) {
            return FALSE;
        }
	}
		
	public function validVideo($videoID) {
		$headers = @get_headers($this->client . "videos/" . $videoID);
		
		if(!strpos($headers[0], '200')) {
			#echo "The YouTube video you entered does not exist";
			return FALSE;
		}
		
		return TRUE;
	}
	
	private function getResult() {
		switch(strtolower($this->format)) {
			case "json":
				$results = $this->json_request(str_replace(array("&alt=array", "?alt=array"), array("&alt=json", "?alt=json"), $this->uri));
				
				if($results) {
					if($results->feed->{'openSearch$totalResults'}->{'$t'} > 0) {
						return $results;
					} else {
						return FALSE;
					}
				} else {
					return FALSE;
				}
			break;
				
			case "xml":
				return @simplexml_load_file(str_replace("&alt=xml", "", $this->uri));
			break;
			
			case "array":
				$results = $this->json_request(str_replace(array("&alt=array", "?alt=array"), array("&alt=json", "?alt=json"), $this->uri));
				
				if($results) {
					if(isset($results->entry) and !isset($results->feed)) {
						$entry = $results->entry;
						
						$data = array(
							"id"       => (isset($entry->{'media$group'}->{'yt$videoid'}->{'$t'})) ? $entry->{'media$group'}->{'yt$videoid'}->{'$t'} : $this->id($entry->id->{'$t'}),
							"title"    => $entry->title->{'$t'},
							"cut"      => $this->cut($entry->title->{'$t'}),
							"content"  => (isset($entry->content->{'$t'})) ? $entry->content->{'$t'} : $entry->{'media$group'}->{'media$description'}->{'$t'},
							"keywords" => explode(",", $entry->{'media$group'}->{'media$keywords'}->{'$t'}),
							"category" => $entry->category[1]->label,
							"date"     => strtotime($entry->published->{'$t'}),
							"views"    => $entry->{'yt$statistics'}->viewCount
						);
						
						return $data;
					} else {
						if($results->feed->{'openSearch$totalResults'}->{'$t'} > 0) {
							foreach($results->feed->entry as $entry) {
								$data["videos"][] = array(
									"id" 	   => (isset($entry->{'media$group'}->{'yt$videoid'}->{'$t'})) ? $entry->{'media$group'}->{'yt$videoid'}->{'$t'} : $this->id($entry->id->{'$t'}),
									"title"    => $entry->title->{'$t'},
									"cut" 	   => $this->cut($entry->title->{'$t'}),
									"content"  => (isset($entry->content->{'$t'})) ? $entry->content->{'$t'} : $entry->{'media$group'}->{'media$description'}->{'$t'},
									"keywords" => explode(",", $entry->{'media$group'}->{'media$keywords'}->{'$t'}),
									"category" => $entry->category[1]->label,
									"date"     => strtotime($entry->published->{'$t'}),
									"views"    => $entry->{'yt$statistics'}->viewCount
								);
							}
							
							$data["self"] = $this->self($results->feed->link);
							$data["next"] = $this->next($results->feed->link);
							$data["prev"] = $this->prev($results->feed->link);
							
							return $data;
						} else {
							return FALSE;
						}
					}
				} else {
					return FALSE;
				}
			break;
			
			default:
				return $this->json_request($this->uri);
			break;
		}
	}
	
	private function json_request($url) {
		$curl = curl_init();
		
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
		
		$response = curl_exec($curl);
		
		curl_close($curl);
		
		return json_decode($response);
	}
	
	private function id($entry) {
		$_array = explode("/", $entry);

		return $_array[count($_array) - 1];
	}
	
	private function cut($title, $start = 0, $end = 50, $text = "...") {
		return substr($title, $start, $end) . $text;
	}
	
	private function self($link) {
		if(is_array($link)) {
			foreach($link as $value) {
				if($value->rel == "self") {
					return $value->href;
				}
			}
			
			return FALSE;
		} else {
			return FALSE;
		}
	}
	
	private function next($link) {
		if(is_array($link)) {
			foreach($link as $value) {
				if($value->rel == "next") {
					return $value->href;
				}
			}
			
			return FALSE;
		} else {
			return FALSE;
		}
	}
	
	private function prev($link) {
		if(is_array($link)) {
			foreach($link as $value) {
				if($value->rel == "prev") {
					return $value->href;
				}
			}
			
			return FALSE;
		} else {
			return FALSE;
		}
	}
}
