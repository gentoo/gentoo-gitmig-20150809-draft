# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-8.0.12-r2.ebuild,v 1.1 2009/01/31 10:58:19 ulm Exp $

inherit elisp eutils

DESCRIPTION="The VM mail reader for Emacs"
HOMEPAGE="http://www.nongnu.org/viewmail/"
SRC_URI="http://download.savannah.nongnu.org/releases/viewmail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="bbdb ssl"

DEPEND="bbdb? ( app-emacs/bbdb )"
RDEPEND="${DEPEND}
	ssl? ( net-misc/stunnel )"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-autoload-vm-pine.patch" #246185
	epatch "${FILESDIR}/${P}-supercite-yank.patch" #256886

	if ! use bbdb; then
		elog "Excluding vm-pcrisis.el since the \"bbdb\" USE flag is not set."
		epatch "${FILESDIR}/vm-8.0-no-pcrisis.patch"
	fi

	# fix vm-version, bug 235563
	#sed -i -e "/^(defvar vm-version /s/nil/\"${PV}\"/" lisp/vm-version.el \
	#	|| die "sed failed"
}

src_compile() {
	local myconf
	use bbdb && myconf="--with-other-dirs=${SITELISP}/bbdb"
	econf --with-emacs="emacs" \
		--with-pixmapdir="/usr/share/pixmaps/vm" \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc NEWS README TODO example.vm || die "dodoc failed"
}
