# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/setools/setools-1.4.ebuild,v 1.3 2004/07/24 18:02:27 method Exp $

DESCRIPTION="SELinux policy tools"
HOMEPAGE="http://www.tresys.com/selinux_policy_tools.html"
SRC_URI="http://www.tresys.com/Downloads/selinux-tools/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X gtk selinux"

DEPEND="sys-devel/bison
	sys-devel/flex
	dev-libs/libxml2
	dev-util/pkgconfig
	selinux? ( sys-libs/libselinux )
	X? ( dev-lang/tk gtk? ( >=gnome-base/libglade-2.0 ) )"

RDEPEND="dev-libs/libxml2
	selinux? ( sys-libs/libselinux )
	X? (
		dev-lang/tk
		>=dev-tcltk/bwidget-1.4.1
		gtk? ( >=gnome-base/libglade-2.0 )
	)"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix the Makefile to listen to portage CFLAGS
	sed -i -e "s:-O2:-O2 ${CFLAGS}:" ${S}/Makefile

	# fix up the scripts we're going to install
	sed -i -e 's:local/selinux/::g' ${S}/seuser/seuseradd
	sed -i -e 's:local/selinux/::g' ${S}/seuser/seuserdel
	sed -i -e 's:local/selinux/::g' ${S}/seuser/seusermod

	# we will manually install policy
#	sed -i -e "s: policy-install::g" ${S}/seuser/Makefile

	# fix up the paths in the file contexts
#	sed -i -e 's:/usr/apol:/usr/share/setools:' ${S}/policy/seuser.fc

	# dont chcon or install -Z
	sed -i -e '/chcon/d' ${S}/secmds/Makefile
	sed -i -e '/chcon/d' ${S}/seuser/Makefile
	sed -i -e 's,-Z system_u:object_r:seuser_exec_t,,g' ${S}/seuser/Makefile
	sed -i -e 's,-Z system_u:object_r:seuser_conf_t,,g' ${S}/seuser/Makefile
	sed -i -e 's,-Z system_u:object_r:policy_src_t,,g' ${S}/seuser/Makefile

	# dont do findcon or replcon if USE=-selinux
	if ! use selinux; then
		sed -i -e '/^SE_CMDS/s/replcon//' ${S}/secmds/Makefile
		sed -i -e '/^SE_CMDS/s/findcon//' ${S}/secmds/Makefile
	fi

	# adjust policy settings in seuser.conf
	echo "policy_dir         ${POLICYDIR}" > ${S}/seuser/seuser.conf
	echo "policy.conf        ${POLICYDIR}/policy.conf" >> ${S}/seuser/seuser.conf
	echo "file_contexts_file ${POLICYDIR}/file_contexts/file_contexts" >> ${S}/seuser/seuser.conf
	echo "user_file          ${POLICYDIR}/users" >> ${S}/seuser/seuser.conf
}

src_compile() {
	cd ${S}

	# build command line tools
	make all-nogui || die "command line tools compile failed"

	if use X; then
		make apol sepcut seuserx \
			|| die "apol, sepcut, or seuserx compile failed"

		if use gtk; then
			make seaudit || die "seaudit compile failed."
		fi

	fi
}

src_install() {
	cd ${S}

	dodoc COPYING ChangeLog-setools README

	# some of the Makefiles are broken, and will fail
	# if ${D}/usr/bin is nonexistant
	dodir /usr/bin

	# command line tools
	make DESTDIR=${D} install-secmds \
		|| die "secmds install failed."

	if use X; then
		# graphical tools

		make DESTDIR=${D} install-apol install-sepcut \
			|| die "apol and sepcut install failed."

		if use gtk; then
			make DESTDIR=${D} install-seaudit \
				|| die "seaudit install failed."
		fi
	fi

	if use selinux; then
		if use X; then
			make DESTDIR=${D} install-seuserx \
				|| die "seuserx install failed."
		else
			make DESTDIR=${D} install-seuser \
				|| die "seuser install failed."
		fi

		insinto ${POLICYDIR}/domains/program
		doins ${S}/policy/seuser.te
		insinto ${POLICYDIR}/file_contexts/program
		doins ${S}/policy/seuser.fc
	fi
}

pkg_postinst() {
	einfo "Installed tools:"
	echo
	einfo "seinfo"
	einfo "sesearch"
	if use X; then
		einfo "apol"
		einfo "sepcut"
		use gtk && einfo "seaudit"
	fi
	if use selinux; then
		einfo "findcon"
		einfo "replcon"
		einfo "seuser"
		use X && einfo "seuserx"
		einfo "seuseradd"
		einfo "seuserdel"
		einfo "seusermod"
		echo
		einfo "A policy for the seuser program has been installed into"
		einfo "${POLICYDIR}.  Please reload your policy and relabel"
		einfo "setools:  rlpkg setools"
	fi
}
