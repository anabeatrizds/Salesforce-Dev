<apex:page >
    <apex:pageBlock title="ShowImage">
        <apex:pageBlockSection>
            <apex:image url="{!URLFOR($Resource.vfimagetest, 'cats/kitten1.jpg')}"/>
        </apex:pageBlockSection>
    </apex:pageBlock>
</apex:page>