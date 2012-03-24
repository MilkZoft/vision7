			<a name="top"></a>

			<div id="pages">		
				<p>
					<h2><?php print $title; ?></h2>
				</p>
				
				<p>
					<?php print $content; ?>
				</p>
				
				<?php
					if(isset($actions)) {
						?>
							<div class="actions"><?php print $actions; ?></div>
							<div class="clear"></div>
						<?php
					}
				?>
			</div>
