#!/bin/bash
# -*- ENCODING: UTF-8 -*-
psconfig="{
  \"name\": \"$1\",
  \"version\": \"1.0.0\",
  \"description\": \"\",
  \"main\": \"script.ts\",
  \"scripts\": {
    \"start\": \"nodemon ./script.ts\",
    \"dev\": \"tsc && node ./build/script.js\",
    \"build\": \"tsc --project ./tsconfig.json\",
    \"test\": \"jest --clearCache && node --no-warnings --experimental-vm-modules node_modules/jest/bin/jest.js --watchAll -c ./jest.unit.ts\",
    \"jest\": \"jest -c ./jest.unit.ts\",
    \"test:coverage\": \"jest --coverage -c ./jest.unit.ts on\"
  },
  \"author\": \"westindev\",
  \"license\": \"ISC\"
}"

tsconfig="{
 \"compilerOptions\": {
    \"target\": \"ES2022\",                                 
    \"module\": \"ES2022\",                                  
    \"rootDir\": \"./\",                                     
    \"moduleResolution\": \"node\",                          
    \"types\": [\"jest\", \"node\"],                         
    \"outDir\": \"./build\",                                 
    \"esModuleInterop\": true,                             
    \"forceConsistentCasingInFileNames\": true,            
    \"strict\": true,                                      
    \"skipLibCheck\": true                              
  }
}"

imptsjest="import type { JestConfigWithTsJest } from 'ts-jest';"

configjest="const jestConfig: JestConfigWithTsJest = {

  preset: 'ts-jest/presets/default-esm', 
  moduleNameMapper: {
    '^(\\\\.{1,2}/.*)\\\\.js$': '\$1',
  },
  transform: {
    '^.+\\\\.tsx?$': [
      'ts-jest',
      {
        useESM: true,
      },
    ],
  },
  coverageDirectory: './coverage',
  testMatch: [
    '**/?(*.)+(spec|test).ts'
  ],
  resetMocks: true,
  clearMocks: true,
  verbose: true
}"


npm init -y 
echo $psconfig > package.json 
npm i --save-dev typescript jest @types/jest @types/node ts-jest ts-node nodemon 
npx tsc --init
echo $tsconfig > tsconfig.json
touch jest.unit.ts
echo $imptsjest > jest.unit.ts
echo $configjest >> jest.unit.ts
echo "
export default jestConfig" >> jest.unit.ts
touch script.ts
touch script.test.ts
echo "the script: $0 is done ! You are ready to work with typescript and jest:)"
exit