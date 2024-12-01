#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# init npm project
npm init -y --silent


psconfig='{
    "name": "tsj",
    "version": "1.0.0",
    "scripts": {
        "start": "nodemon ./script.ts",
        "dev": "tsc && node ./build/script.js",
        "build": "tsc --project ./tsconfig.json",
        "test": "jest --clearCache && node --no-warnings --experimental-vm-modules node_modules/jest/bin/jest.js --watchAll -c ./jest.unit.ts",
        "jest": "jest -c ./jest.unit.ts",
        "test:coverage": "jest --coverage -c ./jest.unit.ts on"
    },
    "author": "westindev"
}'

# create package.json
echo $psconfig > package.json 
# install dependencies
npm i --save-dev typescript jest @types/jest @types/node ts-jest ts-node nodemon 

tsconfig='{
    "compilerOptions": {
        "target": "ES2022",
        "module": "ES2022",
        "rootDir": "./",
        "moduleResolution": "node",
        "types": [
            "jest",
            "node"
        ],
        "outDir": "./build",
        "esModuleInterop": true,
        "forceConsistentCasingInFileNames": true,
        "strict": true,
        "skipLibCheck": true
    }
}'

# create tsconfig.json
echo "$tsconfig" > tsconfig.json

jestConfig="import type { JestConfigWithTsJest } from 'ts-jest';

const jestConfig: JestConfigWithTsJest = {
  preset: 'ts-jest/presets/default-esm', 
  transform: {
    '^.+\\\.tsx?$': [
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
};

export default jestConfig;"

# create jest.unit.ts
echo "$jestConfig" > jest.unit.ts

# create script.ts and script.test.ts
touch script.ts
touch script.test.ts
echo "the script: ts-jest.sh is done ! You are ready to work with typescript and jest now:)"
exit