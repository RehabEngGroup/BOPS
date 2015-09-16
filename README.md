BOPS (Batch OpenSim Processing Scripts)
=======================================

BOPS performs batch processing of common OpenSim procedures (Inverse Kinematics - IK, Inverse Dynamics - ID, Muscle Analysis - MA, and Static Optimization - SO) and stores output, logging information, setup files, and plots in an ordered structure of folders. 

We implemented BOPS using OpenSim APIs, that receive the following information through setup files: (i) weight of each marker (IK); (ii) external loads (ID); (iii) whether moment arms should be computed (MA); (iv) configuration of Static Optimization through the Analyze Tool, and actuators (SO); (v) muscle groups of interest (plotting). We provide already few setup files but the user is in charge of defining appropriate configuration for the data. 

A MATLAB graphical user interface (GUI) is available to customize the execution of procedures. The use of the GUI is not limited in selecting the setup files. The user can also select: (i) the OpenSim procedures to execute, (ii) the trials to process, (iii) the cut-off frequencies for coordinate filtering, (iv) the coordinates/joint moments/muscles properties to plot and the x-axis label. 

BOPS stores its outputs in folders that are automatically created. These folders integrate perfectly in the structure provided by MOtoNMS software (<https://simtk.org/home/motonms>). We designed the two tools to work in close cooperation to transform the data collected in a motion analysis laboratory in inputs for OpenSim and CEINMS (<https://simtk.org/home/ceinms>) tools.
 
## Latest Version ##
BOPS is an open project, released under Apache v2.0 License and hosted in [GitHub] [1]. 
An archive of the latest release is freely available from the SimTK project page: 
<https://simtk.org/home/bops> together with a dataset to play with. 

## Documentation ##
A PDF version of the BOPS User Manual will soon be uploaded in <https://simtk.org/home/bops>.
Meanwhile, please refer to this README for a basic introduction.

## Installation ##

1. Configure MATLAB for the use of OpenSim API (follow the instructions available [here] [3])

2. Unzip the archive of BOPS (available [here][2]) 

This release includes three directories:

- src:        BOPS source code
- Templates:  XML setup files for OpenSim IK, ID, MA, SO tools, and for configuration of output plots .
- TestData:   Example datasets from three different laboratories. Users are provided with the same data available in MOtoNMS (available also [here][4]) plus scaled .osim models.

## Execution ##

#### Using the GUI ####

1. Set MATLAB path to BOPS/src folder
2. Run BOPSgui.m

##### How to set the processing input  #####
BOPS requires an input folder for its execution. Please select a folder in the dynamicElaborations folder created by MOtoNMS tool. If you are not familiar with this folder structure you can refer to the [MOtoNMS User Manual] [5].

### Advanced use ###
The use of the GUI is not mandatory. Advanced users can create a main.m script and call directly the functions. An example with some notes is provided.

## WARNINGS ##
- Install BOPS in a folder that you can modify. Therefore, DO NOT install BOPS in Administrator folders, such as the Program Files folder;
- File Paths MUST not include blank spaces due to a limitation in OpenSim SO.

## Contacts ##
- If you need help using BOPS, please ask your questions in the BOPS Public Forum, available from the SimTK project page: <https://simtk.org/home/bops>, or send an email to <ali.mantoan@gmail.com> and <monica.reggiani@gmail.com>
- You can send BOPS bug reports to <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>
- If you want to participate in developing BOPS, please send an email to <monica.reggiani@gmail.com>

## Redistribution: Terms and Conditions ## 

Copyright (C) 2015 Alice Mantoan, Monica Reggiani
 
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
     http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.

When using BOPS, please acknowledge the authors.

========

[1]: https://github.com/RehabEngGroup/OpenSimProcessingScripts
[2]: https://simtk.org/home/bops
[3]: http://simtk-confluence.stanford.edu:8080/display/OpenSim/Scripting+with+Matlab
[4]: https://simtk.org/home/motonms
[5]: http://rehabenggroup.github.io/MOtoNMS/manual/folders.html#data-organization

