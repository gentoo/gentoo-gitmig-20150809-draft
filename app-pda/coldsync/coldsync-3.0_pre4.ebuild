# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/coldsync/coldsync-3.0_pre4.ebuild,v 1.1 2006/03/12 08:04:33 robbat2 Exp $

DESCRIPTION="A command-line tool to synchronize PalmOS PDAs with Unix workstations"
MY_PV="${PV/_/-}"
SRC_URI="http://www.coldsync.org/download/coldsync-${MY_PV}.tar.gz"
HOMEPAGE="http://www.coldsync.org/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="nls perl usb caps"

DEPEND="usb? ( >=dev-libs/libusb-0.1.10a )
		perl? ( dev-lang/perl )
		caps? ( sys-libs/libcap )"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	local myconf
	#use nls || myconf="${myconf} --without-i18n"
	#use perl || myconf="${myconf} --without-perl"

	myconf="${myconf} `use_with perl`"
	myconf="${myconf} `use_with nls i18n`"
	myconf="${myconf} `use_with usb libusb`"
	myconf="${myconf} `use_with caps capabilities`"

	econf ${myconf} || die "configuring coldsync failed"
	make || die "couldn't make coldsync"
}

src_install() {
	make \
	PREFIX=${D}/usr \
	MANDIR=${D}/usr/share/man \
	SYSCONFDIR=${D}/etc \
	DATADIR=${D}/usr/share \
	INFODIR=${D}/usr/share/info \
	INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLSITEMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLVENDORMAN3DIR=${D}/usr/share/man/man3 \
	EXTRA_INFOFILES="" \
	install || die "couldn't install coldsync"
	use perl && rm -f ${D}/usr/lib/perl5/*/*/perllocal.pod

	dodoc AUTHORS Artistic ChangeLog HACKING INSTALL NEWS README TODO
}
