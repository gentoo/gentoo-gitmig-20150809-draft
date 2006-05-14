# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ghemical/ghemical-2.01.ebuild,v 1.2 2006/05/14 05:56:58 spyderous Exp $

inherit eutils

DESCRIPTION="Ghemical supports both quantum-mechanics (semi-empirical and ab initio) models and molecular mechanics models (there is an experimental Tripos 5.2-like force field for organic molecules). Also a tool for reduced protein models is included. Geometry optimization, molecular dynamics and a large set of visualization tools are currently available."
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://bioinformatics.org/ghemical/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="threads openbabel toolbar"
RDEPEND="virtual/glut
	virtual/glu
	virtual/opengl
	>=x11-libs/gtk+-2.6
	>=x11-libs/gtkglext-1.0.5
	>=gnome-base/libglade-2.4
	>=sci-libs/libghemical-2
	openbabel? ( >=sci-chemistry/openbabel-2 )
	threads? ( >=dev-libs/glib-2.4 )
	|| ( x11-libs/libXmu virtual/x11 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15"

pkg_setup() {
	# Only works with xorg-x11 GL implementation
	GL_IMPLEM=$(eselect opengl show)
	eselect opengl set xorg-x11
}

src_compile() {
	econf \
		$(use_enable toolbar shortcuts) \
		$(use_enable openbabel) \
		$(use_enable threads) \
		--enable-gamess \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	# sed -e "s:^prefix=.*:prefix=${D}/usr:" -i Makefile
	make DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	eselect opengl set ${GL_IMPLEM}
}
