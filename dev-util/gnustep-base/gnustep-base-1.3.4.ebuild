# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-base/gnustep-base-1.3.4.ebuild,v 1.4 2002/07/19 17:27:49 raker Exp $

DESCRIPTION="GNUstep base package"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL"
DEPEND=">=dev-util/gnustep-make-1.3.4"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"

src_compile() {
	. /usr/GNUstep/System/Makefiles/GNUstep.sh
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--with-xml-prefix=/usr \
		--with-gmp-include=/usr/include \
		--with-gmp-library=/usr/lib || die "./configure failed"
	make || die
}

src_install () {
	dodir	/usr/GNUstep/System/Makefiles/Additional
	insinto /usr/GNUstep/System/Makefiles/Additional
	doins base.make

	dodir	/usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu
	cd ${WORKDIR}/${P}/Source/shared_obj/ix86/linux-gnu/gnu-gnu-gnu
	insinto /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu
	doins libgnustep-base.so.1.3.4	
	dosym /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so.1.3.4 \
		/usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so.1
	dosym /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so.1 \
		/usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so

	dodir	/usr/GNUstep/System/Headers/Foundation
	cd ${WORKDIR}/${P}/Headers/gnustep/base
	insinto /usr/GNUstep/System/Headers/Foundation
	doins Foundation.h NSByteOrder.h NSConcreteNumber.h \
		NSPathUtilities.h NSSerialization.h NSUtilities.h GSMime.h \
		GSXML.h NSArchiver.h NSArray.h NSAttributedString.h \
		NSAutoreleasePool.h NSBitmapCharSet.h NSBundle.h \
		NSCalendarDate.h NSCharacterSet.h NSClassDescription.h \
		NSCoder.h NSConnection.h NSData.h NSDate.h NSDateFormatter.h \
		NSDebug.h NSDecimal.h NSDecimalNumber.h NSDictionary.h \
		NSDistantObject.h NSDistributedLock.h \
		NSDistributedNotificationCenter.h NSEnumerator.h \
		NSException.h NSFileHandle.h NSFileManager.h NSFormatter.h \
		NSGeometry.h NSHashTable.h NSHost.h NSInvocation.h \
		NSKeyValueCoding.h NSLock.h NSMapTable.h NSMethodSignature.h \
		NSNotification.h NSNotificationQueue.h NSNull.h \
		NSNumberFormatter.h NSObjCRuntime.h NSObject.h NSPort.h \
		NSPortCoder.h NSPortMessage.h NSPortNameServer.h \
		NSProcessInfo.h NSProtocolChecker.h NSProxy.h NSRange.h \
		NSRunLoop.h NSScanner.h NSSet.h NSString.h NSTask.h \
		NSThread.h NSTimeZone.h NSTimer.h NSURL.h NSURLHandle.h \
		NSUndoManager.h NSUserDefaults.h NSValue.h NSZone.h \
		objc-load.h

	dodir	/usr/GNUstep/System/Headers/gnustep/base
	cd ${WORKDIR}/${P}/Headers/gnustep/base
	insinto /usr/GNUstep/System/Headers/gnustep/base
	doins DistributedObjects.h GSLocale.h GSUnion.h GSIArray.h \
		GSIMap.h Unicode.h UnixFileHandle.h behavior.h numbers.h \
		objc-gnu2next.h preface.h

	dodir	/usr/GNUstep/System/Headers/gnustep/unicode
	cd ${WORKDIR}/${P}/Headers/gnustep/unicode
	insinto /usr/GNUstep/System/Headers/gnustep/unicode
	doins caseconv.h cop.h cyrillic.h latin2.h decomp.h nextstep.h

	dodir	/usr/GNUstep/System/Headers/ix86/linux-gnu
	cd ${WORKDIR}/${P}/Source/ix86/linux-gnu
	insinto /usr/GNUstep/System/Headers/ix86/linux-gnu
	doins GSConfig.h mframe.h

	#These lines are already in /etc/services
	#gdomap 538/tcp # GNUstep distrib objects
	#gdomap 538/udp # GNUstep distrib objects

	cd ${WORKDIR}/${P}/SSL
	dodir	/usr/GNUstep/System/Library/Bundles
	rm -f .tmp.gnustep.exclude
	echo "SSL.bundle/Contents/Resources" > .tmp.gnustep.exclude
	tar chfX - .tmp.gnustep.exclude SSL.bundle \
	| (cd ${D}/usr/GNUstep/System/Library/Bundles; tar xf -)
	rm -f .tmp.gnustep.exclude
	dodir	/usr/GNUstep/System/Library/Bundles/SSL.bundle/Contents
	rm -rf Resources
	ln -s ../Resources .

	cd ${WORKDIR}/${P}/Tools/shared_obj/ix86/linux-gnu/gnu-gnu-gnu
	insinto /usr/GNUstep/System/Tools/ix86/linux-gnu/gnu-gnu-gnu
	insopts -m 0755
	doins autogsdoc cvtenc gdnc gsdoc defaults plmerge plparse \
		sfparse pldes plser pl2link HTMLLinker

	insinto /usr/GNUstep/System/Tools/ix86/linux-gnu
	insopts -m 04755
	doins gdomap

	cd ${WORKDIR}/${P}/Tools/make_strings/shared_obj/ix86/linux-gnu/gnu-gnu-gnu
	insinto /usr/GNUstep/System/Tools/ix86/linux-gnu/gnu-gnu-gnu
	insopts -m 0755
	doins make_strings

	dodir	/usr/GNUstep/System/Libraries/Resources/NSCharacterServer
	cd ${WORKDIR}/${P}/NSCharacterSets
	insinto /usr/GNUstep/System/Libraries/Resources/NSCharacterSets
	insopts -m 0644
	doins alphanumericCharSet.dat controlCharSet.dat \
		decimalDigitCharSet.dat decomposableCharSet.dat \
		illegalCharSet.dat letterCharSet.dat \
		lowercaseLetterCharSet.dat nonBaseCharSet.dat \
		punctuationCharSet.dat symbolAndOperatorCharSet.dat \
		uppercaseLetterCharSet.dat whitespaceAndNlCharSet.dat \
		whitespaceCharSet.dat README.CharSet

	dodir	/usr/GNUstep/System/Libraries/Resources
	cd ${WORKDIR}/${P}/NSTimeZones
	insinto /usr/GNUstep/System/Libraries/Resources
	doins NSTimeZones.tar
	cd ${D}/usr/GNUstep/System/Libraries/Resources
	tar -xf NSTimeZones.tar
	rm -f NSTimeZones.tar

	cd ${WORKDIR}/${P}/Resources/Languages
	dodir	/usr/GNUstep/System/Libraries/Resources/Languages
	insinto /usr/GNUstep/System/Libraries/Resources/Languages
	doins Dutch English French German Italian Russian Slovak \
		UkraineRussian Locale.aliases
}
