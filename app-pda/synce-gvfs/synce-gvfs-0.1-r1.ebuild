# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gvfs/synce-gvfs-0.1-r1.ebuild,v 1.3 2009/01/25 05:22:49 mr_bones_ Exp $

inherit autotools gnome2

DESCRIPTION="SynCE - Gnome GVFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

gvfs_PV="1.0.3"
gvfs_P="gvfs-${gvfs_PV}"
gvfs_S="${WORKDIR}/${gvfs_P}"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz
	mirror://gnome/sources/gvfs/${gvfs_PV%.*}/${gvfs_P}.tar.gz"

RDEPEND=">=gnome-base/${gvfs_P}
		~app-pda/synce-libsynce-0.12
		~app-pda/synce-librapi2-0.12"
DEPEND="dev-util/gtk-doc
	${RDEPEND}"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# backport from svn:
	mkdir make-dist
	for i in common-Makefile.am configure.ac.in \
	         daemon-Makefile.am make-dist.sh; do
		cp "${FILESDIR}/${i}" make-dist/
	done
	einfo "Running make-dist.sh (copy ${gvfs_P} src from ${gvfs_S})"
	sed -i 's:^\(gvfs_src_dir=\).*$:\1"'${gvfs_S}'":' make-dist/make-dist.sh
	( cd make-dist ; sh make-dist.sh )
	eautoreconf
}

src_compile() {
	econf --with-gvfs-source="${gvfs_S}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
