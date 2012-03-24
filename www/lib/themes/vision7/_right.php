<?php if(!defined("_access")) die("Error: You don't have permission to access here..."); ?>

<div id="sidebar">
	<?php print $this->execute("Polls_Controller", "last"); ?>
	
	<p class="center">
		<?php print $this->execute("Ads_Controller", "ads", array("Right")); ?>
	</p>
	
	<p class="center">
		<?php print $this->execute("Blog_Controller", "archive"); ?>
	</p>
</div>