# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/gtkada/gtkada-2.2.0.ebuild,v 1.1 2003/07/14 23:13:21 george Exp $

Name="GtkAda"
DESCRIPTION="Gtk+ bindings to the Ada language"
HOMEPAGE="http://libre.act-europe.fr/GtkAda"
SRC_URI="http://libre.act-europe.fr/${Name}/${Name}-${PV}.tgz"

LICENSE="GMGPL"
SLOT="1"
KEYWORDS="~x86"
IUSE="nls opengl"

DEPEND="dev-lang/gnat
	>=x11-libs/gtk+-2.2.0"
RDEPEND=""

S="${WORKDIR}/${Name}-${PV}"

inherit gnat

src_compile() {
	local myconf
	myconf=""

	use nls    || myconf="${myconf} --disable-nls"
	use opengl && myconf="${myconf} --with-GL=auto"

	patch -p1 < ${FILESDIR}/${P}-gentoo.patch

#	./configure \
#		--host=${CHOST} \
#		--prefix=/usr \
#		--infodir=/usr/share/info \
#		--mandir=/usr/share/man \
	econf ${myconf} || die "./configure failed"

	make GNATFLAGS="${ADACFLAGS}" || die
}

src_install() {
	make prefix=${D}/usr \
		incdir=${D}/usr/lib/ada/adainclude/gtkada \
		libdir=${D}/usr/lib/ada/adalib/gtkada \
		alidir=${D}/usr/lib/ada/adalib/gtkada install \
		|| die

	#arrange docs properly
	dodoc ANNOUNCE AUTHORS COPYING README
	cd ${D}/usr
	mv doc/${Name}/* share/${PN}/examples/ share/doc/${PF}
	rm -rf doc/ share/${PN}/
	cd ${S} #in case need to add anything afterwards
}

