# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5o_p2.ebuild,v 1.1 2005/01/08 02:10:18 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

NV="${PV/_p}"
DESCRIPTION="Standard commands to read man pages"
HOMEPAGE="http://freshmeat.net/projects/man/"
SRC_URI="mirror://kernel/linux/utils/man/man-${NV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls"

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="sys-apps/cronbase
	>=sys-apps/groff-1.18
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}-${NV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:/usr/lib/locale:$(prefix)/usr/lib/locale:g' \
		-e 's!/usr/bin:/usr/ucb:!/usr/bin:!' \
		configure || die "configure sed failed"

	# Make sure man2html respects our CFLAGS
	epatch ${FILESDIR}/man-1.5o_p1-man2html-CFLAGS.patch

	# security fix
	epatch ${FILESDIR}/man-1.5m-security.patch

	# Fix search order in man.conf so that system installed manpages
	# will be found first ...
	epatch ${FILESDIR}/man-1.5m-search-order.patch

	# For groff-1.18 or later we need to call nroff with '-c'
	epatch ${FILESDIR}/man-1.5m-groff-1.18.patch

	# Various fixes from Redhat
	epatch ${FILESDIR}/man-1.5m-redhat-patches.patch

	# Do not print the 'man: No such file or directory' error if
	# 'man -d' was called and the NLS catalogue was not found, as
	# it confuses people, and be more informative  ... (bug #6360)
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/man-1.5m-locale-debug-info.patch

	# Line length overidden by nroff macros, thanks to 
	# <grant.mcdorman@sympatico.ca> for the patch, (bug #21018). 
	# 	-taviso@gentoo.org
	epatch ${FILESDIR}/man-1.5m-LL-linelength.patch

	# makewhatis traverses manpages twice, as default manpath
	# contains two directories that are symlinked together
	# (bug 23848)
	#  -taviso@gentoo.org
	epatch ${FILESDIR}/man-1.5m-defmanpath-symlinks.patch

	# Make sure the locale is searched in the right order #37778
	epatch ${FILESDIR}/man-1.5m-locale-order.patch

	# Fix cross compiling ... a few build apps need to be compiled 
	# with the native gcc instead of target gcc
	epatch ${FILESDIR}/man-1.5m-cross-compile.patch

	# use non-lazy binds for man. And let portage handling stripping.
	append-ldflags -Wl,-z,now
	sed -i \
		-e "/^LDFLAGS = -s/s:=.*:=${LDFLAGS}:" \
		${S}/src/Makefile.in \
		|| die "failed to edit default LDLFAGS"
}

src_compile() {
	tc-export CC BUILD_CC

	local myconf=
	use nls && myconf="+lang all" || myconf="+lang none"
	./configure \
		-confdir=/etc \
		+sgid +fhs \
		${myconf} || die "configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/{bin,sbin}
	make PREFIX="${D}" install || die "make install failed"
	dosym man /usr/bin/manpath

	insinto /etc
	doins src/man.conf

	dodoc LSM README* TODO

	if use nls ; then
		cd "${S}/msgs"
		./inst.sh ?? "${D}"/usr/share/locale/%L/%N
	fi

	# Needed for makewhatis
	keepdir /var/cache/man
	exeinto /etc/cron.weekly
	newexe "${FILESDIR}/makewhatis.cron" makewhatis

	fowners root:man /usr/bin/man
	fperms 2555 /usr/bin/man

	diropts -m0775 -g man
	local mansects=$(grep ^MANSECT "${D}"/etc/man.conf | cut -f2-)
	for x in ${mansects//:/ } ; do
		keepdir /var/cache/man/cat${x}
	done
}

pkg_postinst() {
	einfo "Forcing sane permissions onto ${ROOT}/var/cache/man (Bug #40322)"
	chown -R root:man "${ROOT}/var/cache/man"
	chmod -R g+w "${ROOT}/var/cache/man"
	[ -e "${ROOT}/var/cache/man/whatis" ] \
		&& chown root:root "${ROOT}/var/cache/man/whatis"

	echo

	local files="`ls ${ROOT}/etc/cron.{daily,weekly}/makewhatis{,.cron} 2>/dev/null`"
	if [ "${files/$'\n'}" != "${files}" ] ; then
		ewarn "You have multiple makewhatis cron files installed."
		ewarn "You might want to delete all but one of these:"
		echo ${files}
	fi
}
