# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/sharutils/sharutils-4.6.1_pre4.ebuild,v 1.1 2006/01/06 08:20:36 dragonheart Exp $

inherit autotools

MY_P="${P/_/-}"
DESCRIPTION="Tools to deal with shar archives"
HOMEPAGE="http://www.gnu.org/software/sharutils/"
SRC_URI="http://autogen.sourceforge.net/data/${MY_P}.tar.gz"
#SRC_URI="mirror://gnu/${PN}/REL-${PV}/${P}.tar.bz2
#		mirror://gnu/${PN}/REL-${PV}/${P}-doc.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="nls"
#IUSE="nls doc"
S="${WORKDIR}/${MY_P}"

DEPEND="sys-apps/texinfo
	nls? ( >=sys-devel/gettext-0.10.35 )"

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	#if use doc; then
	#	tar -zxf ${DISTDIR}/${P}-doc.tar.gz -C ${D}/usr/share/doc \
	#		|| die 'documentation installation failed'
	#fi
}
