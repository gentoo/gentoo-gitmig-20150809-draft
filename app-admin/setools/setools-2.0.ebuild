# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/setools/setools-2.0.ebuild,v 1.4 2005/03/29 19:24:28 pebenito Exp $

DESCRIPTION="SELinux policy tools"
HOMEPAGE="http://www.tresys.com/selinux_policy_tools.html"
SRC_URI="http://www.tresys.com/Downloads/selinux-tools/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="X debug selinux"

DEPEND="sys-devel/bison
	sys-devel/flex
	dev-libs/libxml2
	dev-util/pkgconfig
	selinux? ( sys-libs/libselinux )
	X? (
		dev-lang/tk
		>=gnome-base/libglade-2.0
	)"

RDEPEND="dev-libs/libxml2
	selinux? ( sys-libs/libselinux )
	X? (
		dev-lang/tk
		>=dev-tcltk/bwidget-1.4.1
		>=gnome-base/libglade-2.0
	)"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix the Makefile to listen to portage CFLAGS
	sed -i -e "/^CFLAGS/s/-O2/${CFLAGS}/g" ${S}/Makefile

	# enable debug if requested
	useq debug && sed -i -e '/^DEBUG/s/0/1/' ${S}/Makefile

	# generate the file contexts from the template
	sed -e 's:SEUSER_BINDIR:/usr/bin:' \
		-e 's:SEUSER_INSTALL_LIBDIR:/usr/share/setools:' \
		< ${S}/policy/seuser_template.fc > ${S}/policy/seuser.fc

	# dont chcon or install -Z
	sed -i -e '/object_r/d' ${S}/secmds/Makefile
	sed -i -e '/object_r/d' ${S}/seuser/Makefile
	sed -i -e 's,-Z system_u:object_r:etc_t,,g' ${S}/seaudit/Makefile

	# dont do findcon, replcon, searchcon, or indexcon if USE=-selinux
	if ! useq selinux; then
		sed -i -e '/^USE_LIBSELINUX/s/1/0/' ${S}/Makefile
		sed -i -e '/^SE_CMDS/s/replcon//' \
			-e '/^SE_CMDS/s/findcon//' \
			-e '/^SE_CMDS/s/searchcon//' \
			-e '/^SE_CMDS/s/indexcon//' ${S}/secmds/Makefile
	fi

	# adjust policy settings in seuser.conf
	echo "policy_dir         ${POLICYDIR}" > ${S}/seuser/seuser.conf
	echo "policy.conf        ${POLICYDIR}/policy.conf" >> ${S}/seuser/seuser.conf
	echo "file_contexts_file ${POLICYDIR}/file_contexts/file_contexts" >> ${S}/seuser/seuser.conf
	echo "user_file          ${POLICYDIR}/users" >> ${S}/seuser/seuser.conf
}

src_compile() {
	cd ${S}

	if useq X; then
		make all || die
	else
		make all-nogui || die
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

	if useq X; then
		# graphical tools
		make DESTDIR=${D} install-apol install-sepcut install-seaudit install-sediffx \
			|| die "Graphical tool install failed."
	fi

	if useq selinux; then
		if useq X; then
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
	if useq selinux; then
		einfo "A policy for the seuser program has been installed into"
		einfo "${POLICYDIR}.  Please reload your policy and relabel"
		einfo "setools:  rlpkg setools"
	fi
}
