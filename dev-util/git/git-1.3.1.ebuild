# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git/git-1.3.1.ebuild,v 1.1 2006/04/25 20:17:11 ferdy Exp $

inherit python toolchain-funcs eutils

DOC_VER=${PV}

DESCRIPTION="GIT - the stupid content tracker"
HOMEPAGE="http://kernel.org/pub/software/scm/git/"
SRC_URI="mirror://kernel/software/scm/git/${P}.tar.bz2
		mirror://gentoo/${PN}-man-${DOC_VER}.tar.bz2
		doc? ( mirror://gentoo/${PN}-html-${DOC_VER}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="mozsha1 ppcsha1 doc curl X webdav"

DEPEND="dev-libs/openssl
		sys-libs/zlib
		!app-misc/git
		curl? ( net-misc/curl )
		webdav? ( dev-libs/expat )"
RDEPEND="${DEPEND}
		dev-lang/perl
		>=dev-lang/python-2.3
		app-text/rcs
		X? ( dev-lang/tk )"

# This is needed because for some obscure reasons future calls to make don't
# pick up these exports if we export them in src_unpack()
exportmakeopts() {
	local myopts

	if use mozsha1 ; then
		myopts="${myopts} MOZILLA_SHA1=YesPlease"
	elif use ppcsha1 ; then
		myopts="${myopts} PPC_SHA1=YesPlease"
	fi

	if use curl ; then
		use webdav || myopts="${myopts} NO_EXPAT=YesPlease"
	else
		myopts="${myopts} NO_CURL=YesPlease"
		use webdav && ewarn "USE=webdav only matters with USE=curl. Ignoring."
	fi

	myopts="${myopts} WITH_SEND_EMAIL=YesPlease"

	# Older python versions need own subproccess.py
	python_version
	[[ ${PYVER} < 2.4 ]] && myopts="${myopts} WITH_OWN_SUBPROCESS_PY=YesPlease"

	use elibc_uclibc && myopts="${myopts} NO_ICONV=YesPlease"

	export MY_MAKEOPTS=${myopts}
}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:^\(CFLAGS = \).*$:\1${CFLAGS} -Wall:" \
		-e "s:^\(LDFLAGS = \).*$:\1${LDFLAGS}:" \
		-e "s:^\(CC = \).*$:\1$(tc-getCC):" \
		-e "s:^\(AR = \).*$:\1$(tc-getAR):" \
		Makefile || die "sed failed"

	exportmakeopts
}

src_compile() {
	emake ${MY_MAKEOPTS} prefix=/usr || die "make failed"
}

src_install() {
	make ${MY_MAKEOPTS} DESTDIR=${D} prefix=/usr install || die "make install failed"

	use X || rm ${D}/usr/bin/gitk

	doman ${WORKDIR}/${PN}-man-${DOC_VER}/man?/*

	dodoc README COPYING Documentation/SubmittingPatches
	if use doc ; then
		dodoc Documentation/technical/*
		dodir /usr/share/doc/${PF}/html
		cp -r ${WORKDIR}/${PN}-html-${DOC_VER}/* ${D}/usr/share/doc/${PF}/html
	fi

	newinitd "${FILESDIR}/git-daemon.initd" git-daemon
	newconfd "${FILESDIR}/git-daemon.confd" git-daemon
}

src_test() {
	cd ${S}
	make ${MY_MAKEOPTS} test || die "tests failed"
}

pkg_postinst() {
	einfo
	einfo "If you want to import arch repositories into git, consider using the"
	einfo "git-archimport command. You should install dev-util/tla before"
	einfo
	einfo "If you want to import cvs repositories into git, consider using the"
	einfo "git-cvsimport command. You should install >=dev-util/cvsps-2.1 before"
	einfo
	einfo "If you want to import svn repositories into git, consider using the"
	einfo "git-svnimport command. You should install dev-util/subversion before"
	einfo
	einfo "If you want to use the included CVS server you will need to install"
	einfo "dev-perl/DBI and dev-perl/DBD-SQLite"
	einfo
}
