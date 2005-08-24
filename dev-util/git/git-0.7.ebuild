# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git/git-0.7.ebuild,v 1.8 2005/08/24 20:53:21 gustavoz Exp $

DESCRIPTION="GIT - the stupid content tracker"
HOMEPAGE="http://kernel.org/pub/software/scm/git/"
SRC_URI="http://kernel.org/pub/software/scm/git/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc sparc"
IUSE="mozsha1 ppcsha1"

DEPEND="dev-libs/openssl
		sys-libs/zlib
		net-misc/curl
		!dev-util/cogito
		!app-misc/git"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-g -O2:${CFLAGS}:" \
		Makefile
}

src_compile() {
	if use mozsha1; then
		export MOZILLA_SHA1=yes
	elif use ppcsha1; then
		export PPC_SHA1=yes
	fi

	emake || die "make failed"
}

src_install() {
	dobin git-cat-file git-check-files git-checkout-cache git-commit-tree \
		git-convert-cache git-diff-cache git-diff-files git-diff-tree \
		git-diff-tree-helper git-export git-fsck-cache git-http-pull \
		git-init-db git-ls-tree git-merge-base git-merge-cache git-mktag \
		git-prune-script git-pull-script git-read-tree git-rev-list \
		git-rev-tree git-rpull git-rpush git-show-files git-tag-script \
		git-tar-tree git-unpack-file git-update-cache git-write-tree \
		git-merge-one-file-script

	dodoc README || die "dodoc failed"
}
