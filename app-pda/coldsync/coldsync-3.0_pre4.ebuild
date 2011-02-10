# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/coldsync/coldsync-3.0_pre4.ebuild,v 1.3 2011/02/10 15:06:25 ssuominen Exp $

EAPI=2

MY_PV=${PV/_/-}

DESCRIPTION="A command-line tool to synchronize PalmOS PDAs with Unix workstations"
HOMEPAGE="http://www.coldsync.org/"
SRC_URI="http://www.coldsync.org/download/coldsync-${MY_PV}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE="nls perl usb caps"

RDEPEND="usb? ( virtual/libusb:0 )
	perl? ( dev-lang/perl )
	caps? ( sys-libs/libcap )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${MY_PV}

src_configure() {
	local myconf
	#use nls || myconf="${myconf} --without-i18n"
	#use perl || myconf="${myconf} --without-perl"

	myconf="${myconf} `use_with perl`"
	myconf="${myconf} `use_with nls i18n`"
	myconf="${myconf} `use_with usb libusb`"
	myconf="${myconf} `use_with caps capabilities`"

	econf ${myconf}
}

src_compile() {
	emake -j1 || die #279292
}

src_install() {
	emake \
		PREFIX="${D}"/usr \
		MANDIR="${D}"/usr/share/man \
		SYSCONFDIR="${D}"/etc \
		DATADIR="${D}"/usr/share \
		INFODIR="${D}"/usr/share/info \
		INSTALLMAN3DIR="${D}"/usr/share/man/man3 \
		INSTALLSITEMAN3DIR="${D}"/usr/share/man/man3 \
		INSTALLVENDORMAN3DIR="${D}"/usr/share/man/man3 \
		EXTRA_INFOFILES="" \
		install || die

	use perl && rm -f "${D}"/usr/lib/perl5/*/*/perllocal.pod

	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
