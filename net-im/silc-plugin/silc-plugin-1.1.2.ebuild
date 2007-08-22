# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-plugin/silc-plugin-1.1.2.ebuild,v 1.3 2007/08/22 06:48:08 ticho Exp $

inherit eutils perl-module

IRSSI_PV="0.8.10a"

DESCRIPTION="A SILC plugin for Irssi"
HOMEPAGE="http://penguin-breeder.org/silc/"
SRC_URI="http://www.silcnet.org/download/client/sources/silc-client-${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

# All necessary dependencies are pulled in by irssi.
DEPEND="=dev-libs/glib-1.2*
	www-client/lynx"	# this is for .html -> .txt docs convert
RDEPEND=">=net-irc/irssi-${IRSSI_PV%a}
	>=dev-perl/MIME-tools-5.413
	dev-perl/File-MMagic
	dev-perl/MailTools"

S="${WORKDIR}/silc-client-${PV}"

pkg_setup() {
	if ! built_with_use irssi perl ; then
		die "Irssi was built without perl support, building a perl plugin makes no sense."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s:-g -O2:${CFLAGS}:g" configure
	use amd64 && sed -i -e 's:felf\([^6]\):felf64\1:g' configure
}

src_compile() {

	econf \
			${myflags} \
			--with-silc-plugin \
			--without-silc-includes \
			--with-pic \
			|| die

	emake || die
}

src_install() {
	local myflags

	R1="s/installsitearch='//"
	R2="s/';//"
	perl_sitearch="`perl -V:installsitearch | sed -e ${R1} -e ${R2}`"
	myflags="${myflags} INSTALLPRIVLIB=/usr/$(get_libdir)"
	myflags="${myflags} INSTALLARCHLIB=${perl_sitearch}"
	myflags="${myflags} INSTALLSITELIB=${perl_sitearch}"
	myflags="${myflags} INSTALLSITEARCH=${perl_sitearch}"

	make DESTDIR="${D}" ${myflags} install || die

	dodoc ${D}/usr/share/doc/silc-client/*
	rm -rf ${D}/usr/share/doc/silc-client

	fixlocalpod
}

pkg_postinst() {
	elog "You can load the plugin with following command in Irssi:"
	elog
	elog "\t/LOAD silc"
	elog
	elog "It will automatically generate a new key pair for you. You will be asked to"
	elog "enter a passphrase for this keypair twice. If you leave the passphrase"
	elog "empty, your key will not be stored encrypted."
	elog
	elog "To make full use of silc-plugin, you should load the following perl script"
	elog "into Irssi:"
	elog
	elog "\t/SCRIPT LOAD silc"
	elog
	elog "To connect to the SILCNet, you can use following command:"
	elog
	elog "\t/CONNECT -silcnet SILCNet silc.silcnet.org"
	elog
	elog "Have fun."
}
