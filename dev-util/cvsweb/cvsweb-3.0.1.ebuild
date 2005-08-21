# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsweb/cvsweb-3.0.1.ebuild,v 1.4 2005/08/21 15:13:44 rl03 Exp $

inherit webapp

KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="BSD"
DESCRIPTION="WWW interface to a CVS tree"
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/ports/local-distfiles/scop/${P}.tar.gz"
HOMEPAGE="http://www.freebsd.org/projects/cvsweb.html"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5.8
		>=dev-util/cvs-1.11
		>=app-text/rcs-5.7
		>=dev-perl/URI-1.28
		dev-perl/IPC-Run
		dev-perl/MIME-Types
		dev-perl/String-Ediff
		>=dev-util/cvsgraph-1.4.0
		>=app-text/enscript-1.6.3
"

src_install() {
	webapp_src_preinst

	cp cvsweb.conf ${D}/${MY_HOSTROOTDIR}
	cp css/cvsweb.css ${D}/${MY_HTDOCSDIR}
	exeinto ${MY_CGIBINDIR}
	doexe cvsweb.cgi
	chmod +x ${D}/${MY_CGIBINDIR}/cvsweb.cgi

	dodoc README TODO NEWS ChangeLog

	webapp_hook_script ${FILESDIR}/reconfig
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt
	webapp_src_install
}
