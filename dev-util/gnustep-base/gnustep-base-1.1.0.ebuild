# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Nick Hadaway <raker@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-base/gnustep-base-1.1.0.ebuild,v 1.3 2002/07/08 05:13:15 raker Exp $

DESCRIPTION="GNUstep base package"
HOMEPAGE="http://www.gnustep.org"
LICENSE="LGPL"
DEPEND=">=dev-util/gnustep-make-1.2.1"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
SLOT="0"
S=${WORKDIR}/${P}

src_compile() {
	# Source the GNUstep environment
	. /usr/GNUstep/System/Makefiles/GNUstep.sh

	cd ${S}
	./configure \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--sysconfdir=/etc \
		--localstatedir=/var/state/gnustep-base \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--enable-ffcall \
		--with-openssl-include=/usr/include/openssl \
		--with-openssl-library=/usr/lib \
		--with-gmp-include=/usr/include \
		--with-gmp-library=/usr/lib || die "./configure failed"

	emake || die
}

src_install () {

	mkdir -p ${D}/usr/GNUstep/System/Headers/Foundation \
		${D}/usr/GNUstep/System/Headers/gnustep/base \
		${D}/usr/GNUstep/System/Headers/gnustep/unicode \
		${D}/usr/GNUstep/System/Makefiles/Additional \
		${D}/usr/GNUstep/System/Libraries/Resources/Languages

	cd ${S}
	insinto /usr/GNUstep/System/Makefiles/Additional
	insopts -m 644
	doins base.make

	cd ${S}/Source/shared_obj/ix86/linux-gnu/gnu-gnu-gnu
	insinto /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu
	insopts -m 644
	doins libgnustep-base.so.1.1.0
	dosym /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so.1.1.0 \
		/usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so.1
	dosym /usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so.1 \
		/usr/GNUstep/System/Libraries/ix86/linux-gnu/gnu-gnu-gnu/libgnustep-base.so

	cd ${S}/Headers/gnustep/base
	insinto /usr/GNUstep/System/Headers/Foundation
	insopts -m 644
	doins Foundation.h NSByteOrder.h NSConcreteNumber.h \
	NSKeyValueCoding.h NSPathUtilities.h NSSerialization.h NSUtilities.h \
	GSMime.h GSXML.h NSArchiver.h NSArray.h NSAttributedString.h \
	NSAutoreleasePool.h NSBitmapCharSet.h NSBundle.h NSCalendarDate.h \
	NSCharacterSet.h NSClassDescription.h NSCoder.h NSConnection.h \
	NSData.h NSDate.h NSDateFormatter.h NSDebug.h NSDecimal.h \
	NSDecimalNumber.h NSDictionary.h NSDistantObject.h \
	NSDistributedLock.h NSDistributedNotificationCenter.h \
	NSEnumerator.h NSException.h NSFileHandle.h NSFileManager.h \
	NSFormatter.h NSGeometry.h NSHashTable.h NSHost.h NSInvocation.h \
	NSLock.h NSMapTable.h NSMethodSignature.h NSNotification.h \
	NSNotificationQueue.h NSNull.h NSNumberFormatter.h NSObjCRuntime.h \
	NSObject.h NSPort.h NSPortCoder.h NSPortMessage.h NSPortNameServer.h \
	NSProcessInfo.h NSProtocolChecker.h NSProxy.h NSRange.h NSRunLoop.h \
	NSScanner.h NSSet.h NSString.h NSTask.h NSThread.h NSTimeZone.h \
	NSTimer.h NSURL.h NSURLHandle.h NSUndoManager.h NSUserDefaults.h \
	NSValue.h NSZone.h objc-load.h

	cd ${S}/Source
	echo "SSL.bundle/Contents/Resources" > .tmp.gnustep.exclude
	tar chfX - .tmp.gnustep.exclude SSL.bundle \
		| (cd ${D}/usr/GNUstep/System/Library/Bundles; tar xf -)
	rm -f .tmp.gnustep.exclude
	cd ${D}/usr/GNUstep/System/Library/Bundles/SSL.bundle/Contents
	ln -s ../Resources .

	cd ${S}/Headers/gnustep/base
	insinto /usr/GNUstep/System/Headers/gnustep/base
	insopts -m 644
	doins e.h UnixFileHandle.h behavior.h numbers.h o_array.h \
		o_array_bas.h o_array_cbs.h o_cbs.h o_hash.h o_hash_bas.h \
		o_hash_cbs.h o_list.h o_list_bas.h o_list_cbs.h o_map.h \
		o_map_bas.h o_map_cbs.h objc-gnu2next.h preface.h

	cd ${S}/Headers/gnustep/unicode
	insinto /usr/GNUstep/System/Headers/gnustep/unicode
	insopts -m 644
	doins caseconv.h cop.h cyrillic.h latin2.h decomp.h nextstep.h

	cd ${S}/Source/ix86/linux-gnu
	insinto /usr/GNUstep/System/Headers/ix86/linux-gnu
	insopts -m 644
	doins GSConfig.h mframe.h

	#These lines are already in /etc/services
        #gdomap 538/tcp # GNUstep distrib objects
        #gdomap 538/udp # GNUstep distrib objects

	cd ${S}/Tools/shared_obj/ix86/linux-gnu/gnu-gnu-gnu
	insinto /usr/GNUstep/System/Tools/ix86/linux-gnu/gnu-gnu-gnu
	insopts -m 0755
	doins autogsdoc gdnc gsdoc defaults plmerge plparse sfparse \
		pldes plser pl2link HTMLLinker 

	insinto /usr/GNUstep/System/Tools/ix86/linux-gnu/gnu-gnu-gnu
	insopts -m 4755
	doins gdomap

	cd ${S}/NSCharacterSets
	insinto /usr/GNUstep/System/Libraries/Resources/NSCharacterSets
	insopts -m 644
	doins alphanumericCharSet.dat controlCharSet.dat \
		decimalDigitCharSet.dat decomposableCharSet.dat \
		illegalCharSet.dat letterCharSet.dat \
		lowercaseLetterCharSet.dat nonBaseCharSet.dat \
		punctuationCharSet.dat symbolAndOperatorCharSet.dat \
		uppercaseLetterCharSet.dat whitespaceAndNlCharSet.dat \
		whitespaceCharSet.dat README.CharSet

	cd ${S}/NSTimeZones
	cp NSTimeZones.tar ${D}/usr/GNUstep/System/Libraries/Resources
	cd ${D}/usr/GNUstep/System/Libraries/Resources
	tar -xf NSTimeZones.tar
	rm -f NSTimeZones.tar

	cd ${S}/Resources/Languages
	insinto /usr/GNUstep/System/Libraries/Resources/Languages
	insopts -m 644
	doins Dutch English French German Italian Locale.aliases
}
