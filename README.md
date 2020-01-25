A little tool to view Sennen Sensou Aigis's event scenes in web browser
This allows to use Google Translate addon to translate event text automatically from Japanese to English

### Installing

Install Haxe and npm:

```
https://haxe.org/
https://www.npmjs.com/
```

Extract unit data using AigisTools, we have a script "allunits.bat" that can be used to get unit data up to Shadia:

```
https://aigis.fandom.com/wiki/User_blog:ShinyAfro/Aigis_Tools_3.0
```

After that, go to AigisTools/out/Units and copy every folders to ./build/girls

Install dependencies by executing the following command:

```
npm run install
```

Generate data.json that contains necessary information for the app to read girls directory (we need to perform this action every time we update units):

```
haxe build-data.hxml
```

Finally execute the following command to run the app:

```
npm run start
```