# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/gtkada/gtkada-2.2.1-r1.ebuild,v 1.3 2004/12/04 13:52:04 dsd Exp $

inherit gnat eutils

Name="GtkAda"
DESCRIPTION="Gtk+ bindings to the Ada language"
HOMEPAGE="http://libre.act-europe.fr/GtkAda"
SRC_URI="http://libre.act-europe.fr/${Name}/${Name}-${PV}.tgz"

LICENSE="GMGPL"
SLOT="1"
KEYWORDS="x86 ~ppc"
IUSE="nls opengl"

DEPEND=">=dev-lang/gnat-3.14p
	>=x11-libs/gtk+-2.2.0
	>=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/${Name}-${PV}"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	local myconf
	myconf=""

	use nls    || myconf="${myconf} --disable-nls"
	use opengl && myconf="${myconf} --with-GL=auto"

	sed -i -e "s|-I\$prefix/include|-I/usr/lib/ada/adainclude|" \
		src/gtkada-config.in
	sed -i -e "s|-L\$prefix/include|-L/usr/lib/ada/adalib|" \
		src/gtkada-config.in

	econf ${myconf} || die "./configure failed"

	make GNATFLAGS="${ADACFLAGS}" || die
}

src_install() {
	make prefix=${D}/usr \
		incdir=${D}/usr/lib/ada/adainclude/gtkada \
		libdir=${D}/usr/lib/ada/adalib/gtkada \
		alidir=${D}/usr/lib/ada/adalib/gtkada install \
		|| die

	dosym /usr/lib/ada/adalib/gtkada/libgtkada_glade-2.2.so.1 /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgtkada_gl-2.2.so.1 /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgnomeada-2.2.so.1 /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgtkada-2.2.so.1 /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgtkada_glade.so /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgtkada_gl.so /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgnomeada.so /usr/lib
	dosym /usr/lib/ada/adalib/gtkada/libgtkada.so /usr/lib

	#arrange docs properly
	dodoc ANNOUNCE AUTHORS COPYING README
	cd ${D}/usr
	mv doc/${Name}/* share/${PN}/examples/ share/doc/${PF}
	rm -rf doc/ share/${PN}/
	cd ${S} #in case need to add anything afterwards

	#set up environment
	dodir /etc/env.d
	echo "ADA_OBJECTS_PATH=/usr/lib/ada/adalib/${PN}" \
		> ${D}/etc/env.d/55gtkada
	echo "ADA_INCLUDE_PATH=/usr/lib/ada/adainclude/${PN}" \
		>> ${D}/etc/env.d/55gtkada
}

pkg_postinst() {
	einfo "The environment has been set up to make gnat automatically find files for"
	einfo "GtkAda. In order to immediately activate these settings please do:"
	einfo "env-update"
	einfo "source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}

