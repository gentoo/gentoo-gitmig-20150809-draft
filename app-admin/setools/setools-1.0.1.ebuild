# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/setools/setools-1.0.1.ebuild,v 1.2 2003/11/20 21:31:03 pebenito Exp $

DESCRIPTION="SELinux graphical policy tools"
HOMEPAGE="http://www.tresys.com/selinux_policy_tools.html"
SRC_URI="http://www.tresys.com/Downloads/selinux-tools/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${P}"
KEYWORDS="x86"
IUSE="selinux"

DEPEND="sys-devel/bison
	sys-devel/flex
	dev-lang/tk"

RDEPEND="dev-lang/tk
	>=dev-tcltk/bwidget-1.4.1"

src_unpack() {
	unpack ${A}

	# fix the Makefile to listen to portage CFLAGS
	sed -i -e 's:-O2:-O2 $(EXTRA_CFLAGS):' ${S}/Makefile

	if [ "`use selinux`" ]; then
		# fix up the scripts we're going to install
		cd ${S}/seuser

		sed -i -e 's:local/selinux/::g' seuseradd
		sed -i -e 's:local/selinux/::g' seuserdel
		sed -i -e 's:local/selinux/::g' seusermod

		# fix up the file contexts
		cd ${S}/policy
		sed -i -e 's:local/selinux/::' -e 's:local/::' seuser.fc
	fi
}

src_compile() {
	cd ${S}

	# adjust for tcl/tk versions
	has_version '>=dev-lang/tk-8.4' && \
		TCL_LIBS="-ltk8.4 -ltcl8.4 -lfl -lm -dl" || \
		TCL_LIBS="-ltk8.3 -ltcl8.3 -lfl -lm -dl"

	make TCL_LIBS="${TCL_LIBS}" EXTRA_CFLAGS="${CFLAGS}" all \
		|| die "compile failed"
}

src_install() {
	dodoc COPYING ChangeLog-setools README

	dobin ${S}/apol/apol
	dobin ${S}/awish/awish
	dobin ${S}/sepct/sepcut

	insinto /usr/lib/apol
	doins ${S}/apol/{apol.tcl,apol_help.txt,dta_help.txt,iflow_help.txt}
	doins ${S}/sepct/sepcut_help.txt
	newins ${S}/apol/apol_perm_mapping_ver15 apol_perm_mapping

	if [ "`use selinux`" ]; then
		dobin ${S}/seuser/{seuser,seuseradd,seuserdel,seusermod}
		doins ${S}/seuser/{se_user.tcl,seuser_help.txt,seuser.conf}

		insinto ${POLICYDIR}/domains/program
		doins ${S}/policy/seuser.te
		insinto ${POLICYDIR}/file_contexts/program
		doins ${S}/policy/seuser.fc
	fi
}

pkg_postinst() {
	if [ "`use selinux`" ]; then
		einfo "A policy for the seuser program has been installed into"
		einfo "${POLICYDIR}.  Please reload your policy at relabel"
		einfo "setools:  rlpkg setools"
	fi
}
