# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/setools/setools-20030609.ebuild,v 1.1 2003/07/02 19:17:56 pebenito Exp $

DESCRIPTION="SELinux graphical policy tools"
HOMEPAGE="http://www.tresys.com/selinux_policy_tools.html"
SRC_URI="http://www.tresys.com/Downloads/selinux-tools/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/setools"
KEYWORDS="~x86"
IUSE="selinux"

DEPEND="sys-devel/bison
	sys-devel/flex
	dev-lang/tk"

RDEPEND="dev-lang/tk
	>=dev-tcltk/bwidget-1.4.1
	selinux? ( sys-apps/selinux-small )"

src_compile() {
	# fix stupid hard-coded paths
	cd ${S}/libapol
	sed -e 's:local/::g' < apol_tcl.h > apol_tcl.h.new
	mv -f apol_tcl.h.new apol_tcl.h
	cd ${S}/apol
	sed -e 's:local/selinux/::' < head.tcl > head.tcl.new
	mv -f head.tcl.new head.tcl
	cd ${S}/sepct
	sed -e 's:local/::g' < top.tcl > top.tcl.new
	mv -f top.tcl.new top.tcl
	cd ${S}/seuser
	sed -e 's:local/selinux/::' < seuser_head.tcl > seuser_head.tcl.new
	mv -f seuser_head.tcl.new seuser_head.tcl
	sed -e "s:/etc/security/selinux/src/policy/users:${POLICYDIR}/users:" \
		-e "s:/etc/security/selinux/src/policy$:${POLICYDIR}:" \
			< seuser.conf > seuser.conf.new
	mv -f seuser.conf.new seuser.conf
	cd ${S}

	# fix the Makefile to listen to portage CFLAGS
	sed -e 's:-g:$(EXTRA_CFLAGS):' < Makefile > Makefile.new
	mv -f Makefile.new Makefile

	# adjust for tcl/tk versions
	has_version '>=dev-lang/tk-8.4' && \
		TCL_LIBS="-ltk8.4 -ltcl8.4 -lfl -lm" || \
		TCL_LIBS="-ltk8.3 -ltcl8.3 -lfl -lm"

	emake TCL_LIBS="${TCL_LIBS}" EXTRA_CFLAGS="${CFLAGS}" all \
		|| die "compile failed"

	if [ "`use selinux`" ]; then
		# fix up the scripts we're going to install
		cd ${S}/seuser

		sed -e 's:local/selinux/::g' < seuseradd > seuseradd.new
		sed -e 's:local/selinux/::g' < seuserdel > seuserdel.new
		sed -e 's:local/selinux/::g' < seusermod > seusermod.new
		mv -f seuseradd.new seuseradd
		mv -f seuserdel.new seuserdel
		mv -f seusermod.new seusermod

		# fix up the file contexts
		cd ${S}/policy
		sed -e 's:local/selinux/::' -e 's:local/::' \
			< seuser.fc > seuser.fc.new
		mv -f seuser.fc.new seuser.fc
	fi
}

src_install() {
	dobin ${S}/apol/apol
	dobin ${S}/awish/awish
	dobin ${S}/sepct/sepcut

	insinto /usr/lib/apol
	doins ${S}/apol/{apol.tcl,apol_help.txt}
	doins ${S}/sepct/sepcut_help.txt

	if [ "`use selinux`" ]; then
		dobin ${S}/seuser/{seuser,seuseradd,seuserdel,seusermod}
		doins ${S}/seuser/{se_user.tcl,seuser_help.txt,seuser.conf}

		insinto ${POLICYDIR}/domains/program
		doins ${S}/policy/seuser.te
		insinto ${POLICYDIR}/file_contexts/program
		doins ${S}/policy/seuser.fc
	fi

	dodoc COPYING ChangeLog-setools README
}

pkg_postinst() {
	if [ "`use selinux`" ]; then
		einfo "A policy for the seuser program has been installed into"
		einfo "${POLICYDIR}.  Please reload your policy at relabel"
		einfo "setools:  rlpkg setools"
	fi
}
