# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-plugin/silc-plugin-1.0.3.ebuild,v 1.3 2007/08/22 06:48:08 ticho Exp $

inherit eutils perl-module

IRSSI_PV="0.8.10a"

DESCRIPTION="A SILC plugin for Irssi"
HOMEPAGE="http://penguin-breeder.org/silc/"
SRC_URI="http://www.irssi.org/files/irssi-${IRSSI_PV}.tar.bz2
	http://silcnet.org/download/client/sources/silc-client-${PV}.tar.gz
	http://penguin-breeder.org/silc/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug"

# All necessary dependencies are pulled in by irssi.
DEPEND="=dev-libs/glib-1.2*
	www-client/lynx"	# this is for .html -> .txt docs convert
RDEPEND=">=net-irc/irssi-${IRSSI_PV%a}
	>=dev-perl/MIME-tools-5.413
	dev-perl/File-MMagic
	dev-perl/MailTools"

S_SILC="${S}/../silc-client-${PV}"
S_IRSSI="${S}/../irssi-${IRSSI_PV%a}"

src_compile() {

	echo
	einfo "Preparing silc-client\n"
	cd ${S_SILC}

	local myconf

	myconf="--without-libtoolfix \
		--enable-static \
		--with-helpdir=${D}/usr/share/irssi/help/silc/\
		--without-silc-libs \
		--with-pthreads=no"

	if use debug ; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi

	if use amd64; then
		myconf="${myconf} --with-pic"
	fi

	econf ${myconf} || die "configure failed"

	( MAKEOPTS="-j1" emake -C lib ) || die "silc-client's lib compilation failed"

	echo
	einfo "Patching irssi source for silc-plugin\n"
	cd ${S}
	emake patch IRSSI=${S_IRSSI} SILC=${S_SILC} || die "patching irssi sources failed"

	cd ${S_IRSSI}

	# this tiny patch fixes a compile-time error (bug #67255)  - ticho
	#epatch ${FILESDIR}/${PV}-gcc34.patch || die "${PV}-gcc34.patch failed"

	echo
	einfo "Configuring irssi\n"
	econf --sysconfdir=/etc || die "irssi configure failed"
	echo
	einfo "Compiling silc-plugin\n"
	emake -C src/perl || die "irssi's src/perl compilation failed"
	emake -C src/fe-common/silc || die "irssi's src/fe-common/silc compilation failed"
	emake -C src/silc/core || die "irssi's src/silc/core compilation failed"
}

src_install() {
	cd ${S_IRSSI}
	make -C src/perl/silc DESTDIR=${D} install || die "irssi's src/perl/silc installation failed"
	make -C src/fe-common/silc DESTDIR=${D} install || die "irssi's src/fe-common/silc installation failed"
	make -C src/silc/core install DESTDIR=${D} install ||  die "irssi's src/silc/core installation failed"

	cd ${S_SILC}
	make -C apps/irssi/docs/help install || die "silc-client's helpfiles installation failed"

	cd ${S}
	insinto /usr/share/irssi/scripts
	doins scripts/*

	insinto /usr/share/irssi
	doins default.theme

	dodoc AUTHORS COPYING README USAGE

	# to fix segfault on connect with
	if has_version '<net-irc/irssi-0.8.11'; then
		cd ${D}/usr/$(get_libdir)/irssi/modules
		mv libfe_common_silc.a libfe_silc.a
		mv libfe_common_silc.la libfe_silc.a
		mv libfe_common_silc.so libfe_silc.so
		cd ${S}
	fi

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
	elog "To make full use of silc-plugin, you should load the following perl scripts"
	elog "into irssi:"
	elog
	elog "\t/SCRIPT LOAD silc"
	elog "\t/SCRIPT LOAD silc-mime"
	elog
	elog "To connect to the SILCNet, you can use following command in Irssi:"
	elog
	elog "\t/CONNECT -silcnet SILCNet silc.silcnet.org"
	elog
	elog "Have fun."
}
