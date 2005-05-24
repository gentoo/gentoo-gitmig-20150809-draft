# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-log4cl/cl-log4cl-20050421.ebuild,v 1.2 2005/05/24 18:48:34 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Log4cl is a log library for Common Lisp based on Log4J"
HOMEPAGE="http://common-lisp.net/project/log4cl/index.html"
SRC_URI="mirror://gentoo/log4cl-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/cl-plus"

# Can use dev-lisp/cl-sql too, but this not a hard dependency we should look
# after.  Users should instead (asdf:oos 'asdf:load-op :log4cl) and then, if
# necessary, (asdf:oos 'asdf:load-op :log4cl.db) etc.  :log4cl.syslog requires
# dev-lisp/cl-uffi.

# TODO locate and add UNETWORK library for :log4cl.mail

S=${WORKDIR}/log4cl

CLPACKAGE=log4cl

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-defconstant-gentoo.patch || die
}

src_install() {
	common-lisp-install log4cl.asd *.lisp
	common-lisp-system-symlink
	dodoc NEWS README log4cl.cfg
}
