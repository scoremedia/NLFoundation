NLFoundation
------------
NLFoundation is a compilation of utilities around Foundation classes.

INstallation
------------
Open up the Xcode workspace and select either the NLFoundation-iOS or NLFoundation-Mac scheme. Ensure you are targeting Mac and not iPhone or iPad. You need to target the Mac because the target that it builds is a mock target which compiles the needed static libraries and then uses a script to construct the framework. If you target iPhone or iPad the framework will not be created properly.

Select Product -> Build For -> Profiling to create the framework file. It will be located inside the Build/Products/Release folder of the derived data for the project.
