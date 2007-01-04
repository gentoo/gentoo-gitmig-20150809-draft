# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/k3d/k3d-0.4.5.0.ebuild,v 1.2 2007/01/04 23:07:18 beandog Exp $

inherit eutils

MY_P="${P}-2"
IUSE="truetype doc python ruby"

DESCRIPTION="K-3D is a free 3D modeling, animation, and rendering system."
HOMEPAGE="http://www.k-3d.org/"
SRC_URI="mirror://sourceforge/k3d/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

#virtual/x11
DEPEND="
	virtual/opengl
	virtual/glu
	>=dev-libs/glib-2.2.1
	=x11-libs/gtk+-1.2*
	=dev-libs/libsigc++-1.0*
	>=media-libs/netpbm-10
	media-libs/plib
	media-gfx/imagemagick
	truetype? ( >=media-libs/freetype-2 )
	doc? ( app-text/xmlto )
	python? ( >=dev-lang/python-2.3 )
	" ##ruby support deprecated ruby? ( virtual/ruby )

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	libtoolize --force --copy --automake
	aclocal
	automake --add-missing
	autoconf
}

src_compile(){
	local myconf="--with-plib --without-graphviz"

	use truetype \
		&& myconf="${myconf} --with-freetype" \
		|| myconf="${myconf} --without-freetype"

	use doc \
		&& myconf="${myconf} --with-docbook" \
		|| myconf="${myconf} --without-docbook"

	use python \
		&& myconf="${myconf} --with-python" \
		|| myconf="${myconf} --without-python"

#	use ruby \
#		&& myconf="${myconf} --with-ruby=`ruby -rrbconfig -e 'puts Config::CONFIG["archdir"]'`" \
#		|| myconf="${myconf} --without-ruby"


	econf "CXXFLAGS=${CXXFLAGS}" ${myconf} \
	--without-new-pnmtotiff || die
	emake || die

}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS README TODO
}
