Edit the pipeline you just created

Remove the Print Message step from the stage "Fluffy Test" and add two steps:

	i. Shell Script: sleep 5
	ii. Shell Script: echo Success!


Add one step to the stage "Fluffy Build":

	i. Shell Script: echo Another Placeholder.


Save the pipeline. In the Save dialog, provide the description "Update first pipeline" and save to the default branch (master branch).

