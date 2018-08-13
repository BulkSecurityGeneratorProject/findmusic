import { NgModule } from '@angular/core';

import { FindmusicSharedLibsModule, JhiAlertComponent, JhiAlertErrorComponent } from './';

@NgModule({
    imports: [FindmusicSharedLibsModule],
    declarations: [JhiAlertComponent, JhiAlertErrorComponent],
    exports: [FindmusicSharedLibsModule, JhiAlertComponent, JhiAlertErrorComponent]
})
export class FindmusicSharedCommonModule {}
