# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-gvfs/synce-gvfs-0.2.1.ebuild,v 1.5 2009/01/27 02:08:12 mescalinum Exp $

inherit gnome2

DESCRIPTION="SynCE - Gnome GVFS extensions"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

synce_PV="0.13"

gvfs_PV="1.0.3"
gvfs_P="gvfs-${gvfs_PV}"
gvfs_S="${WORKDIR}/${gvfs_P}"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz
	mirror://gnome/sources/gvfs/${gvfs_PV%.*}/${gvfs_P}.tar.gz"

RDEPEND=">=gnome-base/${gvfs_P}
		=app-pda/synce-libsynce-${synce_PV}*
		=app-pda/synce-librapi2-${synce_PV}*"
DEPEND="dev-util/gtk-doc
	${RDEPEND}"

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# option --with-gvfs-source wants a *relative* path
	# see "help packaging synce-gvfs and gnome-gvfs" on
	# synce-devel list
	ln -s "$gvfs_S" ./gvfs-src-tree
}

src_compile() {
	econf --with-gvfs-source=./gvfs-src-tree || die "configure failed"
	emake dist || die "emake dist failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
