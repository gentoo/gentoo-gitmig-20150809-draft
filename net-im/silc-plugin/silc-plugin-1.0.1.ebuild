# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-plugin/silc-plugin-1.0.1.ebuild,v 1.1 2004/08/31 15:11:48 ticho Exp $

IRSSI_PV=0.8.9

DESCRIPTION="A SILC plugin for Irssi"
HOMEPAGE="http://penguin-breeder.org/silc/"
SRC_URI="http://irssi.org/files/irssi-${IRSSI_PV}.tar.bz2
	http://silcnet.org/download/client/sources/silc-client-${PV}.tar.gz
	http://penguin-breeder.org/silc/download/silc-plugin-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="debug pic"

# All necessary dependencies are pulled in by irssi.
DEPEND="virtual/glibc"
RDEPEND="~net-irc/irssi-0.8.9"

S_SILC="${S}/../silc-client-${PV}"
S_IRSSI="${S}/../irssi-${IRSSI_PV}"

src_compile() {
    local myconf

    echo ${S_SILC}
    use debug && myconf="${myconf} --enable-debug"
    use pic && myconf="${myconf} --with-pic"

    echo
    einfo "Preparing silc-client\n"
    cd ${S_SILC}
    econf --with-helpdir=${D}/usr/share/irssi/help/silc/ \
	--without-libtoolfix \
	--enable-static \
	${myconf}
    make -C lib

    echo
    einfo "Patching irssi source for silc-plugin\n"
    cd ${S}
    make patch IRSSI=${S_IRSSI} SILC=${S_SILC}

    echo
    einfo "Configuring irssi\n"
    cd ${S_IRSSI}
    econf --sysconfdir=/etc
    echo
    einfo "Compiling silc-plugin\n"
    make -C src/perl
    make -C src/fe-common/silc
    make -C src/silc/core
}

src_install() {
    cd ${S_IRSSI}
    make -C src/perl/silc DESTDIR=${D} install
    make -C src/fe-common/silc DESTDIR=${D} install
    make -C src/silc/core install DESTDIR=${D} install

    cd ${S_SILC}
    make -C irssi/docs/help install

    cd ${S}
    insinto /usr/share/irssi/scripts
    doins scripts/*

    insinto /usr/share/irssi
    doins default.theme

    dodoc AUTHORS COPYING README USAGE
}

pkg_postinst() {
    einfo "You can load the plugin with following command in Irssi:"
    einfo
    einfo "\t/LOAD silc"
    einfo
    einfo "It will automatically generate a new key pair for you. You will be asked to"
    einfo "enter a passphrase for this keypair twice. If you leave the passphrase"
    einfo "empty, your key will not be stored encrypted."
    einfo
    einfo "You should also load the perl scripts:"
    einfo
    einfo "\t/SCRIPT LOAD silc"
    einfo "\t/SCRIPT LOAD silc-mime"
    einfo
    einfo "To connect to the SILCNet, you can use following command in Irssi:"
    einfo
    einfo "\t/CONNECT -silcnet SILCNet silc.silcnet.org"
    einfo
    einfo "Have fun."
}
