# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git/git-0.99.7d.ebuild,v 1.2 2005/09/28 08:19:31 iluxa Exp $

inherit python

DESCRIPTION="GIT - the stupid content tracker"
HOMEPAGE="http://kernel.org/pub/software/scm/git/"
SRC_URI="http://kernel.org/pub/software/scm/git/${PN}-core-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="mozsha1 ppcsha1 doc curl tcltk gitsendemail"
S="${WORKDIR}/${PN}-core-${PV}"

DEPEND="dev-libs/openssl
		sys-libs/zlib
		app-text/rcs
		!app-misc/git
		doc? ( >=app-text/asciidoc-7.0.1 app-text/xmlto )"
RDEPEND="${DEPEND}
		dev-lang/perl
		>=dev-lang/python-2.3
		tcltk? ( dev-lang/tk )
		curl? ( net-misc/curl )
		>=dev-util/cvsps-2.1
		dev-perl/String-ShellQuote
		gitsendemail? ( dev-perl/Mail-Sendmail )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-g -O2:${CFLAGS}:" \
		Makefile
}

src_compile() {
	# Use python_version to check for python 2.4.
	# If the user don't have version 2.4 have then we set WITH_OWN_SUBPROCESS_PY
	# that makes use of a suplied version of subprocess.py
	python_version()
	[[ $PYVER < 2.4 ]] && export WITH_OWN_SUBPROCESS_PY=yes

	if use mozsha1; then
		export MOZILLA_SHA1=yes
	elif use ppcsha1; then
		export PPC_SHA1=yes
	fi

	if ! use curl; then
		export NO_CURL=yes
		ewarn "git-http-pull will not be built because you are not"
		ewarn "using the curl use flag"
	fi

	use gitsendemail && export WITH_SEND_EMAIL=yes

	emake prefix=/usr || die "make failed"

	if use doc; then
		cd ${S}/Documentation
		emake || die "make documentation failed"
	fi
}

src_install() {
	make DESTDIR=${D} prefix=/usr install || die "make install failed"

	if use gitsendemail; then
		exeinto /usr/bin
		doexe git-send-email.perl
	fi

	use tcltk || rm ${D}/usr/bin/gitk

	dodoc README COPYING
	use doc && doman Documentation/*.1 Documentation/*.7
}

pkg_postinst() {
	einfo
	einfo "This version of GIT has changed some command names. It this version,"
	einfo "the old commands will still be present but linked to the new ones."
	einfo "The future 0.99.8 version of GIT will NOT have this feature."
	einfo
	einfo "For the complete list of commands that got changed, visist:"
	einfo "http://dev.gentoo.org/~r3pek/git-new-command-list.txt"
	einfo
}
