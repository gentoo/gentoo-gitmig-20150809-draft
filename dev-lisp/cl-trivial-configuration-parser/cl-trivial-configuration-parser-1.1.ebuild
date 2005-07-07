# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-trivial-configuration-parser/cl-trivial-configuration-parser-1.1.ebuild,v 1.1 2005/07/07 14:57:55 mkennedy Exp $

inherit common-lisp

DESCRIPTION="TRIVIAL-CONFIGURATION-PARSER is a Common Lisp library for parsing its own syntax of configuration file"
HOMEPAGE="http://www.cliki.net/trivial-configuration-parser"
SRC_URI="http://www.unmutual.info/software/${P#cl-}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

S=${WORKDIR}/${P#cl-}

CLPACKAGE=${PN#cl-}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README LICENSE demo.conf
}
