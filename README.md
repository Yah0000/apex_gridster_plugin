# APEX Gridster plugin

![](https://img.shields.io/badge/Plug--in_Type-Region-orange.svg)
![](https://img.shields.io/badge/APEX-18.2-success.svg) ![](https://img.shields.io/badge/APEX-19.1-success.svg) ![](https://img.shields.io/badge/APEX-19.2-success.svg) ![](https://img.shields.io/badge/APEX-20.1-success.svg) ![](https://img.shields.io/badge/APEX-20.2-success.svg)
![](https://img.shields.io/badge/Oracle-11g-success.svg) ![](https://img.shields.io/badge/Oracle-12c-success.svg)  ![](https://img.shields.io/badge/Oracle-18c-success.svg)

## Overview

The plug-in enables dynamic drawing of regions based on a SQL query. Users can create their own dashboards adapting regions positions and sizes to their needs and save them in various ways.

#### All features:

- Possibility to lock editing positions and sizes by the user
- Default element position and location can be given in:
  - SQL query
  -  JSON
- Saved regions positions and sizes by end-user can be stored in
  - APEX ITEM
  - Browser Local storage (it also support for public users without an application user)
  - Not stored (always get from defaults positions)
- APEX dynamic action refresh support
- Region colors adjustment
- APEX-like layout



## Reference

1. This plugin based on gridster.js jQuery Plugin https://dsmorse.github.io/gridster.js/ 

   


## Demo

Demo Application installation: 

1. Import the demo app from: **`apex_sample_application/gridster_sample_application.sql`**

   


*Online demo soon available*



## Pre-requisites

- **Oracle Database 11.2g** or later (not tested on earlier versions).

- **Oracle Application Express 18.2** or later (no extra grants needed).

  

## Installation instructions

1. Download the latest release
2. In your application, go to **Shared Components** -> **Plug-ins** and click **Import**
3. Import the plugin file: **`apex_plugin/gridster_plugin.sql`**



## Usage - component settings

1. Parameters are set by (Region attribute) - s. There are:

   - **SQL Query** (Region source) - Source of regions. 
      Example: 

      ```sql
      select 
          ROWNUM ID,
          HEADER, 
          CONTENT,
          ICON 
      from TABLE; 
      ```

      Sample to try out: 

      ```sql
      select
      	ROWNUM ID, 
      	COLUMN_VALUE HEADER, 
      	COLUMN_VALUE || ' <br>'||to_char(CURRENT_TIMESTAMP, 'HH24:MI:SS') CONTENT  , 
      CASE
           WHEN ROWNUM >2 
          THEN   'fa-sun-o'
          else NULL
      END ICON
      from table (apex_string.split('APEX<br>APEX;ORACLE;APEX PLUGIN;SAMPLE DATA;SAMPLE MORE DATA', ';' )) 
      ```

   - **Region identifier** (Region attribute) - Query column with item ID. Connects saved size and position of elements with data from SQL. 

   - **Region header**	(Region attribute) - Query column with headers of regions

   - **Region content**	(Region attribute) - Query column with contents of regions (allows the use HTML)

   - **Region image**	(Region attribute) - Query column with APEX icon class.

   - **Default position based on**	(Region attribute) - source of regions defaults positions and sizes. It is:

      - *Columns* - allows to retrieve the default positions based on the query columns using the following parameters:

         - **Region Column (X position)**	(Region attribute) 
         - **Region row (Y position)**	(Region attribute) 
         - **Region X-size**	(Region attribute) 
         - **Region Y-size**	(Region attribute) 	

      - *JSON* - allows to retrieve the default positions based on the JSON format and set in parameter:

         - **JSON with positions**(Region attribute) 

            JSON structure:
            
            ```JSON
            [
            	{
            		"id": 5,
            		"row": 1,
            		"col": 1,
            		"size_x": 2,
            		"size_y": 1
            	},
            	{...}
            ]
            ```
            
             Sample to try out: 
            
            ```json
            [{"id":5,"row":1,"col":1,"size_x":2,"size_y":1},{"id":3,"row":1,"col":3,"size_x":2,"size_y":1},{"id":1,"row":1,"col":5,"size_x":2,"size_y":2},{"id":2,"row":2,"col":1,"size_x":2,"size_y":1},{"id":4,"row":2,"col":3,"size_x":2,"size_y":1}]
            ```
            

   - **Height**	(Region attribute) - Region height	

   - **Regions headers color**	(Region attribute) - Regions header color

   - **Font default color**	(Region attribute) - Header font default color		

   - **Allow user to change positions**	(Region attribute) - Disabling and enabling the modification and size of regions by end users. If is enabled there are next items:

        - **Save layout button text**	(Region attribute) 
        - **Store user position and size in**	(Region attribute)  - choose where items saved by end users are saved. The possibilities are:
             - *Don't store* -  Position always get from region defaults positions, but users can still change its.
             - *Local storage* - Saves positions in the end user browser (it also support for public users without an application user).
             - *APEX Item* - JSON with items will be stored in APEX item:
                  - **Item to store positions**	(Region attribute)

2. Plugin support refreshing source by dynamic dynamic action

3. Plugin can trigger APEX Dynamic Action after user click "Save layout" button. 

   

## Releases

| Release number | Release date | New features    |
| -------------- | ------------ | --------------- |
| 1.0            | 2020-01-05   | Initial release |



## Planned features in next releases

1. Store position in APEX COLLECTIONS

*If you have idea to new functionality see Support section.*



## Support

1. Plugin is publish in MIT license. 

2. If you find any bugs or you have idea to extend functionality of plugin feel free to use [issues](apex_gridster_plugin/issues) section or send private message.

3. I will be glad to hear about your feedback

   

   
