# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-araneida/cl-araneida-0.9.ebuild,v 1.7 2009/04/09 22:38:41 ulm Exp $

inherit common-lisp eutils

DESCRIPTION="Araneida is small, highly-portable web server for Common Lisp"
HOMEPAGE="http://www.cliki.net/Araneida"
SRC_URI="http://www-jcsu.jesus.cam.ac.uk/ftp/pub/cclan/araneida_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence
	dev-lisp/cl-net-telent-date"
RDEPEND="${DEPEND}"

CLPACKAGE=araneida

S=${WORKDIR}/araneida_${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	insinto $CLSOURCEROOT/araneida
	doins *.asd *.lisp NEWS
	insinto $CLSOURCEROOT/araneida/utility
	doins utility/*.lisp
	insinto $CLSOURCEROOT/araneida/compat
	doins compat/*.lisp
	insinto $CLSOURCEROOT/araneida/doc
	doins doc/*.html doc/*.css doc/*.lisp doc/PLAN
	common-lisp-system-symlink
	dodoc doc/*.txt INSTALL.asdf LICENCE* NEWS Notes README TODO
	dosym $CLSOURCEROOT/araneida/doc/ \
		/usr/share/doc/${PF}/html
	dodoc ${FILESDIR}/README.Gentoo
}
