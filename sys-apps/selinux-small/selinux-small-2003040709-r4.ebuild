# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/selinux-small/selinux-small-2003040709-r4.ebuild,v 1.3 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="SELinux libraries and policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/selinux"

KEYWORDS="x86 amd64 ~ppc ~alpha ~sparc"
IUSE="selinux static"
DEPEND="sys-devel/flex
	sys-libs/pam
        || (
                >=sys-kernel/selinux-sources-2.4.20-r1
                >=sys-kernel/hardened-sources-2.4.20-r1
           )"

RDEPEND="${DEPEND}
	>=dev-python/pexpect-0.97
	>=sys-apps/selinux-base-policy-20030522"

use static && LDFLAGS="-static"

pkg_setup() {
	if [ -z "`use selinux`" ]; then
		eerror "selinux is missing from your USE.  You seem to be using the"
		eerror "incorrect profile.  SELinux has a different profile than"
		eerror "mainline Gentoo.  Make sure the /etc/make.profile symbolic"
		eend 1 "link is pointing to /usr/portage/profiles/selinux-x86-1.4/"
	fi

	if [ ! -f /usr/src/linux/security/selinux/ss/ebitmap.c ]; then
		eerror "The /usr/src/linux symbolic link appears to be incorrect.  It"
		eerror "must be pointing to a selinux-sources or hardened-sources kernel"
		eerror "for selinux-small to compile.  If the link is correct, the"
		eerror "kernel sources may be damaged or incomplete, and will need to"
		eend 1 "be remerged.  Please fix and retry."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.diff
	has_version '>=sys-libs/glibc-2.3.2' && epatch ${FILESDIR}/${P}-newstat.diff
	epatch ${FILESDIR}/${P}-newrole.diff

	ln -s /usr/src/linux ${WORKDIR}/lsm-2.4
}

src_compile() {

	einfo "Compiling checkpolicy"
	cd ${S}/module
		make LSMVER=-2.4 LDFLAGS=${LDFLAGS} all \
			|| die "Checkpolicy compilation failed"

	einfo "Compiling libsecure"
	cd ${S}/libsecure
		make SE_INC=/usr/include/linux/flask EXTRA_CFLAGS="${CFLAGS}" \
			EXTRA_LDFLAGS="${LDFLAGS}" \
			|| die "libsecure compile failed."

	# now set up paths, since the next compiles need libsecure
	LDFLAGS="-L${S}/libsecure/src ${LDFLAGS}"
	LIBSECURE="-I${S}/libsecure/include ${LDFLAGS} -DUSE_PAM"

	einfo "Compiling devfsd module"
	cd ${S}/devfsd
		mv devfsd-conflet selinux-small
		make CFLAGS="${CFLAGS} ${LIBSECURE}" LDFLAGS="${LIBSECURE/-static}" \
			|| die "devfsd compile failed."

	einfo "Compiling setfiles"
	cd ${S}/setfiles
		make CFLAGS="${CFLAGS} ${LIBSECURE}" LDFLAGS="${LDFLAGS}" setfiles \
			|| die "setfiles compile failed."

	einfo "Compiling newrole"
	cd ${S}/utils/newrole
		make CFLAGS="${CFLAGS} ${LIBSECURE/-static} -lcrypt" \
			|| die "newrole compile failed."

	einfo "Compiling run_init"
	cd ${S}/utils/run_init
		make CFLAGS="${CFLAGS} ${LIBSECURE/-static} -lcrypt" \
			|| die "run_init compile failed."

	einfo "Compiling s-wrappers"
	cd ${S}/utils/spasswd
		make CFLAGS="${CFLAGS} ${LIBSECURE}" LDFLAGS="${LDFLAGS} -lcrypt -static" \
			|| die "s-wrappers compile failed."

	einfo "Compiling selopt"
	cd ${S}/selopt
		make COPT_FLAGS="${CFLAGS} ${LIBSECURE}" LDFLAGS="${LDFLAGS}" \
			|| die "selopt compile failed."
}

src_install() {
	# install policy stuff
	dosbin ${S}/module/checkpolicy/checkpolicy
	dosbin ${S}/setfiles/setfiles

	insinto /usr/include
	doins ${S}/libsecure/include/*.h

	insinto /etc/devfs.d
	doins ${S}/devfsd/selinux-small

	dolib.a ${S}/libsecure/src/libsecure.a
	dobin ${S}/libsecure/test/{avc_enforcing,avc_toggle,context_to_sid,sid_to_context,list_sids,chsid,lchsid,chsidfs,get_user_sids}
	dosbin ${S}/libsecure/test/load_policy
	dobin ${S}/utils/spasswd/{sadminpasswd,schfn,schsh,spasswd,suseradd,suserdel,svipw}
	dobin ${S}/utils/run_init/run_init
	dobin ${S}/utils/newrole/newrole
	dosbin ${FILESDIR}/{rlpkg,open_init_pty}

	doman ${S}/setfiles/setfiles.8
	doman ${S}/libsecure/man/man[12]/*
	doman ${S}/utils/newrole/newrole.1
	doman ${S}/utils/run_init/run_init.8

	dobin ${S}/selopt/utils/flmon
	dosbin ${S}/selopt/utils/{ct,pt,qt}
	dosbin ${S}/selopt/scmpd/scmpd
	dodoc ${S}/selopt/doc/*

	exeinto /etc/init.d
	doexe ${FILESDIR}/scmpd

	exeinto /lib/devfsd
	doexe ${S}/devfsd/devfsd-se.so

	# install pam stuff
	insinto /etc/pam.d
	doins ${FILESDIR}/{newrole,run_init}
}

pkg_postinst() {
	einfo
	einfo "To recompile the policy and relabel the filesystem simply run:"
	einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo

	# Stop devfsd from restoring /dev/log, it causes denials.
	# The syslog will create it when it starts.  Recent stock
	# gentoo devfsd.conf's stopped saving /dev/log into dev-state.
	[ -f /lib/dev-state/log ] && rm -f /lib/dev-state/log
}

pkg_config() {
	cd /etc/security/selinux/src/policy

	einfo "Compiling policy"
	make policy || die "Policy compile failed (see above error messages)"

	einfo "Installing policy"
	make install || die "Policy install failed (see above error messages)"

	einfo "Loading policy"
	make load || die "Policy loading failed (see above error messages)"

	einfo "Relabeling filesystems -- This will take a very long time!"
	make relabel || die "Relabeling failed (see above error messages)"
}
