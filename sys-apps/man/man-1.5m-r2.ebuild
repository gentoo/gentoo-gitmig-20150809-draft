# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5m-r2.ebuild,v 1.4 2004/11/12 14:29:05 vapier Exp $

inherit eutils flag-o-matic

NV="1.5m2"
DESCRIPTION="Standard commands to read man pages"
HOMEPAGE="http://freshmeat.net/projects/man/"
SRC_URI="mirror://kernel/linux/utils/man/man-${NV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="nls"

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="sys-apps/cronbase
	>=sys-apps/groff-1.18
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}-${NV}"

src_unpack() {
	unpack ${A}

	cd "${S}" && \
	sed -i \
		-e 's:/usr/lib/locale:$(prefix)/usr/lib/locale:g' \
		-e 's!/usr/bin:/usr/ucb:!/usr/bin:!' \
		-e 's/n l p o/n l p 0p 1p 3p o/' \
		configure || die "configure sed failed"
	sed -i -e 's:cc -o:$(CC) -o:' gencat/Makefile \
		|| die "gencat/Makefile sed failed"
	sed -i -e "/^CFLAGS /s:-O$: ${CFLAGS}:" man2html/Makefile.in \
		|| die "man2html/Makefile.in sed failed"

	# security fix
	epatch ${FILESDIR}/${P}-security.patch

	# Fix search order in man.conf so that system installed manpages
	# will be found first ...
	epatch ${FILESDIR}/${P}-search-order.patch

	# For groff-1.18 or later we need to call nroff with '-c'
	epatch ${FILESDIR}/${P}-groff-1.18.patch

	# Fix wierd failing in rare cases
	epatch ${FILESDIR}/${P}-wrong-quotes-v2.patch

	# Fix a crash when calling man with:  man -k "foo bar" (bug #9761).
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/${P}-util_c-segfault.patch

	# Various fixes from Redhat
	epatch ${FILESDIR}/${P}-redhat-patches.patch

	# Do not print the 'man: No such file or directory' error if
	# 'man -d' was called and the NLS catalogue was not found, as
	# it confuses people, and be more informative  ... (bug #6360)
	# <azarah@gentoo.org> (26 Dec 2002).
	epatch ${FILESDIR}/${P}-locale-debug-info.patch

	# Line length overidden by nroff macros, thanks to 
	# <grant.mcdorman@sympatico.ca> for the patch, (bug #21018). 
	# 	-taviso@gentoo.org
	epatch ${FILESDIR}/${P}-LL-linelength.patch

	# makewhatis traverses manpages twice, as default manpath
	# contains two directories that are symlinked together
	# (bug 23848)
	#  -taviso@gentoo.org
	epatch ${FILESDIR}/${P}-defmanpath-symlinks.patch

	# Make sure the locale is searched in the right order #37778
	epatch ${FILESDIR}/${P}-locale-order.patch

	# use non-lazy binds for man. And let portage handling stripping.
	append-ldflags -Wl,-z,now
	sed -i -e \
		s/'LDFLAGS = -s'/"LDFLAGS:=${LDFLAGS}"/g ${S}/src/Makefile.in \
		|| die "failed to edit default LDLFAGS"
}

src_compile() {
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
	for x in $(awk '
		/^MANSECT/ {
			split($2, sects, ":")
			for (x in sects)
				print "cat" sects[x]
		}' ${D}/etc/man.conf)
	do
		keepdir /var/cache/man/${x}
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
