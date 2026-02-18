// Reexport the native module. On web, it will be resolved to TestPackageModule.web.ts
// and on native platforms to TestPackageModule.ts
export { default } from './TestPackageModule';
export { default as TestPackageView } from './TestPackageView';
export * from  './TestPackage.types';
