# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coreutils/coreutils-5.2.1-r5.ebuild,v 1.2 2005/04/02 01:09:55 vapier Exp $

inherit eutils flag-o-matic

PATCH_VER=0.10
I18N_VER=i18n-0.2
PATCHDIR="${WORKDIR}/patch"

DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls...), text utilities (sort, tr, head, wc..), and shell utilities (whoami, who,...)"
HOMEPAGE="http://www.gnu.org/software/coreutils/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2
	mirror://gentoo/${P}-${I18N_VER}.patch.bz2
	http://dev.gentoo.org/~seemant/distfiles/${P}-patches-${PATCH_VER}.tar.bz2
	http://dev.gentoo.org/~seemant/distfiles/${P}-${I18N_VER}.patch.bz2
	http://dev.gentoo.org/~vapier/dist/${P}-patches-${PATCH_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh ~sparc x86"
IUSE="nls build acl selinux static uclibc"

RDEPEND="selinux? ( sys-libs/libselinux )
	acl? ( sys-apps/acl sys-apps/attr )
	nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.3-r5"
DEPEND="${RDEPEND}
	virtual/libc
	>=sys-apps/portage-2.0.49
	=sys-devel/automake-1.8*
	>=sys-devel/autoconf-2.58
	>=sys-devel/m4-1.4-r1
	!uclibc? ( sys-apps/help2man )"

src_unpack() {
	unpack ${A}

	cd ${S}

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}/mandrake
	epatch ${WORKDIR}/${P}-${I18N_VER}.patch

	# Apply the ACL patches. 
	# WARNING: These CONFLICT with the SELINUX patches
	if use acl ; then
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

	# Sparc32 SMP bug fix -- see bug #46593
	use sparc && echo -ne "\n\n" >> ${S}/src/pr.c

	# Since we've patched many .c files, the make process will 
	# try to re-build the manpages by running `./bin --help`.  
	# When cross-compiling, we can't do that since 'bin' isn't 
	# a native binary, so let's just install outdated man-pages.
	[[ ${CTARGET:-${CHOST}} != ${CHOST} ]] && touch man/*.1
}

src_compile() {
	if ! type -p cvs > /dev/null ; then
		# Fix issues with gettext's autopoint if cvs is not installed,
		# bug #28920.
		export AUTOPOINT="/bin/true"
	fi

	ebegin "Reconfiguring configure scripts (be patient)"
	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5

	mv m4/inttypes.m4 m4/inttypes-eggert.m4
	touch aclocal.m4 configure config.hin \
		Makefile.in */Makefile.in */*/Makefile.in

	aclocal -I m4 || die "aclocal"
	autoconf || die "autoconf"
	automake || die "automake"
	eend $?

	econf \
		--bindir=/bin \
		--enable-largefile \
		$(use_enable nls) \
		$(use_enable selinux) \
		|| die "econf"

	use static && append-ldflags -static
	emake LDFLAGS="${LDFLAGS}" || die "emake"
}

src_test() {
	# Non-root tests will fail if the full path isnt
	# accessible to non-root users
	chmod a+rx "${WORKDIR}"
	addwrite /dev/full
	export RUN_EXPENSIVE_TESTS="yes"
	#export FETISH_GROUPS="portage wheel"
	make check || die "make check failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	# add DIRCOLORS
	insinto /etc
	doins ${FILESDIR}/DIR_COLORS

	# move non-critical packages into /usr
	cd "${D}"
	dodir /usr/bin
	mv bin/{csplit,expand,factor,fmt,fold,join,md5sum,nl,od} usr/bin
	mv bin/{paste,pathchk,pinky,pr,printf,sha1sum,shred,sum,tac} usr/bin
	mv bin/{tail,test,[,tsort,unexpand,users} usr/bin
	cd bin
	local x
	for x in * ; do
		dosym /bin/${x} /usr/bin/${x}
	done

	if ! use build ; then
		cd ${S}
		dodoc AUTHORS ChangeLog* NEWS README* THANKS TODO
	else
		rm -r "${D}"/usr/share
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
