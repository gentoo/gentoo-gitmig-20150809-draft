# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxclient-2xterminalserver/nxclient-2xterminalserver-1.5.0.ebuild,v 1.3 2008/01/14 12:48:27 voyageur Exp $

inherit eutils qt3

DESCRIPTION="2X Terminal Server GPL NX client, based on NoMachine code"
HOMEPAGE="http://www.2x.com/terminalserver/"
SRC_URI="http://code.2x.com/release/linuxterminalserver/src/linuxterminalserver-1.5.0-common-r21-src.tar.gz
	http://code.2x.com/release/linuxterminalserver/src/linuxterminalserver-1.5.0-client-r21-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/openssl
	media-libs/audiofile
	media-libs/jpeg
	media-libs/libpng
	net-print/cups
	sys-libs/zlib
	=x11-libs/qt-3*
	!net-misc/nxclient"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/1.5.0/nxcomp-1.5.0-gcc4.patch
	epatch "${FILESDIR}"/1.5.0/nxcomp-1.5.0-pic.patch

	# Set correct product name
	einfo "Setting official product name"
	find client/nxclient common/nx-X11/programs/Xserver/hw/nxagent/Args.c \
		-type f -exec sed -i "s/@PRODUCT_NAME@/2X TerminalServer/g" {} \;
}

src_compile()
{
	cd "${S}"/common/nxcomp
	econf || die
	emake || die

	cd "${S}"/common/nxssh
	econf || die
	emake || die

	cd "${S}"/client/nxesd
	econf || die
	emake || die

	cd "${S}"/client/nxclient
	econf || die
	emake || die

	cd "${S}"/client/nxclient/nxprint
	emake || die
}

src_install() {
	# we install into /usr/NX, as NoMachine and 2X do

	for x in nxclient nxprint nxssh nxesd ; do
		make_wrapper $x ./$x /usr/NX/bin /usr/NX/lib || die
	done

	into /usr/NX
	dobin client/nxclient/nxclient
	dobin client/nxclient/nxprint/nxprint
	dobin client/nxesd/nxesd
	dobin common/nxssh/nxssh

	dodir /usr/NX/lib
	cp -P common/nxcomp/libXcomp.so* "${D}"/usr/NX/lib || die

	dodir /usr/NX/share
	cp -R client/nxclient/share "${D}"/usr/NX || die

	# Add icons/desktop entries
	doicon client/nxclient/share/icons/*.png
	make_desktop_entry "nxclient" "NX Client" nx-desktop.png
	make_desktop_entry "nxclient -admin" "NX Session Administrator" nxclient-admin.png
	make_desktop_entry "nxclient -wizard" "NX Connection Wizard" nxclient-wizard.png
}
