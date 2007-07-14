# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-8.0.1.465.ebuild,v 1.2 2007/07/14 12:18:22 ulm Exp $

inherit elisp eutils versionator

VM_PV=$(replace_version_separator 3 '-')
VM_P=${PN}-${VM_PV}

DESCRIPTION="The VM mail reader for Emacs"
HOMEPAGE="http://www.nongnu.org/viewmail/"
SRC_URI="http://download.savannah.nongnu.org/releases/viewmail/${VM_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="bbdb"

DEPEND="bbdb? ( app-emacs/bbdb )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${VM_P}"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use bbdb; then
		elog "Excluding vm-pcrisis.el since the \"bbdb\" USE flag is not set."
		epatch "${FILESDIR}/vm-8.0-no-pcrisis.patch"
	fi
}

src_compile() {
	local myconf
	use bbdb && myconf="--with-other-dirs=${SITELISP}/bbdb"
	econf --with-emacs="emacs" ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	emake -j1 prefix="${D}/usr" \
		info_dir="${D}/usr/share/info" \
		install || die "emake install failed"

	# move pixmaps to a more reasonable location
	dodir /usr/share/pixmaps
	mv "${D}/${SITELISP}/vm/pixmaps" "${D}/usr/share/pixmaps/vm"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc NEWS README TODO example.vm || die "dodoc failed"
}
