# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnusim8085/gnusim8085-1.2.89.ebuild,v 1.9 2011/03/21 22:52:31 nirbheek Exp $
EAPI="1"
inherit eutils

DESCRIPTION="A GTK2 8085 Simulator"
HOMEPAGE="http://sourceforge.net/projects/gnusim8085"
SRC_URI="mirror://sourceforge/gnusim8085/GNUSim8085-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0:2
	>=gnome-base/libgnomeui-2.0
	nls? ( >=sys-devel/gettext-0.10.40 )"
DEPEND="${DEPEND}"

S=${WORKDIR}/GNUSim8085-${PV}

src_compile() {
	local myconf
	use nls  || myconf="--disable-nls"

	econf ${myconf} || die "Configuration failed"

	emake gnusim8085_LDADD='$(GNOME_LIBS)' || die "Make failed"
}

src_install() {
	einstall || die "Install Failed!"
	cd ${S}
	dodoc -r README doc/asm_reference.txt doc/examples \
		AUTHORS ChangeLog NEWS TODO
	doman doc/gnusim8085.1
	cd ${D}
	mv usr/doc/GNUSim8085/* ${D}/usr/share/doc/${PF}
	rm -rf usr/doc
}
