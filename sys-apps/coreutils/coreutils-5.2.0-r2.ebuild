# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coreutils/coreutils-5.2.0-r2.ebuild,v 1.12 2004/07/23 20:55:53 seemant Exp $

inherit eutils flag-o-matic

PATCH_VER=0.2
I18N_VER=i18n-0.1
PATCHDIR=${WORKDIR}/patch

DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls...), text utilities (sort, tr, head, wc..), and shell utilities (whoami, who,...)"
HOMEPAGE="http://www.gnu.org/software/coreutils/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	http://www.openi18n.org/subgroups/utildev/patch/${P}-${I18N_VER}.patch.gz
	mirror://gentoo/${P}-gentoo-${PATCH_VER}.tar.bz2
	mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-${I18N_VER}.patch.gz
	mirror://gentoo/${P}-gentoo-${PATCH_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips ~alpha arm hppa amd64 ~ia64 ~ppc64 s390"
IUSE="nls build acl selinux static uclibc"

RDEPEND="selinux? ( sys-libs/libselinux )
	acl? ( !hppa? ( sys-apps/acl sys-apps/attr ) )
	nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.3-r5"
DEPEND="${RDEPEND}
	virtual/libc
	>=sys-apps/portage-2.0.49
	>=sys-devel/automake-1.8.2
	>=sys-devel/autoconf-2.58
	>=sys-devel/m4-1.4-r1
	!uclibc? ( sys-apps/help2man )"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Mandrake's lsw patch caused issues on ia64 and amd64 with ls
	# Reported upstream, but we don't apply it for now
	# mv ${PATCHDIR}/mandrake/019* ${PATCHDIR}/excluded

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/mandrake
	epatch ${WORKDIR}/${P}-${I18N_VER}.patch

	# Fixed patch for s390 to close bug 47965
	# 
	if use s390
	then
		mv ${PATCHDIR}/generic/003* ${PATCHDIR}/excluded
		einfo Applying s390 patches
		epatch ${FILESDIR}/003_all_coreutils-gentoo-uname-s390.patch || die
	fi

	# Apply the ACL patches. 
	# WARNING: These CONFLICT with the SELINUX patches
	if use acl
	then
		mv ${PATCHDIR}/generic/00{1,2,4}* ${PATCHDIR}/excluded
		mv ${PATCHDIR}/selinux/001_all_coreutils-noacl* ${PATCHDIR}/excluded
		EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/acl
	else
		mv ${PATCHDIR}/selinux/001_all_coreutils-acl* ${PATCHDIR}/excluded
	fi

	# patch to remove Stallman's su/wheel group rant (which doesn't apply,
	# since Gentoo's su is not GNU/su, but that from shadow.
	# do not include su infopage, as it is not valid for the su
	# from sys-apps/shadow that we are using.
	# Patch to add processor specific info to the uname output

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/generic

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/extra

	use selinux && EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/selinux

	# sparc32 hack to fix bug #46953
	use sparc && echo -ne "\n\n" >> ${S}/src/pr.c
}

src_compile() {

#	export DEFAULT_POSIX2_VERSION=199209

	if [ -z "`which cvs 2>/dev/null`" ]
	then
		# Fix issues with gettext's autopoint if cvs is not installed,
		# bug #28920.
			export AUTOPOINT="/bin/true"
	fi


	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5

	mv m4/inttypes.m4 m4/inttypes-eggert.m4
	touch aclocal.m4 configure config.hin \
		Makefile.in */Makefile.in */*/Makefile.in

	ebegin "Reconfiguring configure scripts"
	aclocal -I m4 &>/dev/null || die
	autoconf || die
	automake || die
	eend $?

	econf \
		--bindir=/bin \
		--enable-largefile \
		`use_enable nls` \
		`use_enable selinux` || die

	if use static
	then
		emake LDFLAGS=-static || die
	else
		emake || die
	fi
}

src_install() {
	einstall \
		bindir=${D}/bin || die

	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib

	# add DIRCOLORS
	insinto /etc
	doins ${FILESDIR}/DIR_COLORS

	# move non-critical packages into /usr
	mv bin/{csplit,expand,factor,fmt,fold,join,md5sum,nl,od} usr/bin
	mv bin/{paste,pathchk,pinky,pr,printf,sha1sum,shred,sum,tac} usr/bin
	mv bin/{tail,test,tsort,unexpand,users} usr/bin
	cd usr/bin
	ln -s ../../bin/* .

	if ! use build
	then
		cd ${S}
		dodoc AUTHORS ChangeLog* NEWS README* THANKS TODO
	else
		rm -rf ${D}/usr/share
	fi
}

pkg_postinst() {
	# hostname does not get removed as it is included with older stage1
	# tarballs, and net-tools installs to /bin
	if [ -e ${ROOT}/usr/bin/hostname ] && [ ! -L ${ROOT}/usr/bin/hostname ]
	then
		rm -f ${ROOT}/usr/bin/hostname
	fi
}
