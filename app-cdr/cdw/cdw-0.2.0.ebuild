# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdw/cdw-0.2.0.ebuild,v 1.1 2004/01/23 01:39:18 mr_bones_ Exp $

MY_P=${PN}-${PV/_/-}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="gtk2 and ncurses-based console frontend to cdrecord and mkisofs"
HOMEPAGE="http://cdw.sourceforge.net"
SRC_URI="mirror://sourceforge/cdw/${PN}-${PV/_/-}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="nls gtk oggvorbis mysql encode"

RDEPEND="virtual/cdrtools"
DEPEND="sys-libs/ncurses
	sys-libs/zlib
	nls? ( sys-devel/gettext )
	gtk? ( >=x11-libs/gtk+-2
			>=dev-libs/glib-2
			dev-util/pkgconfig )
	oggvorbis? ( media-libs/libvorbis )
	mysql? ( dev-db/mysql )
	encode? ( media-sound/lame )"

src_compile() {
	local myconf

	use oggvorbis \
		&& myconf="${myconf} --with-oggenc=/usr/bin/oggenc" \
		|| myconf="${myconf} `use_with oggvorbis oggenc`"

	use encode \
		&& myconf="${myconf} --with-lame=/usr/bin/lame" \
		|| myconf="${myconf} `use_with encode lame`"

	econf \
		--disable-dependency-tracking \
		${myconf} \
		`use_enable nls` \
		`use_enable gtk gui` || die
	emake -j1 || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS THANKS \
		doc/{KNOWN_BUGS,README*,default.conf} || die "dodoc failed"

	if has_version 'dev-db/mysql'; then
		insinto /usr/share/${PF}/
		doins doc/cdw.sql || die "doins failed"
	fi

	# clean up the docs installed with make install
	rm -rf ${D}/usr/share/doc/${PN}
}

pkg_postinst() {
	if has_version 'dev-db/mysql'; then
		echo
		einfo "You have chosen, either by selecting 'USE=mysql' or maybe"
		einfo "because have installed 'dev-db/mysql' before, to install Disk"
		einfo "Catalog support. You will have a new tool called cdwdic."
		echo
		einfo "The directory /usr/share/${PF}/"
		einfo "contains a cdw.sql file. You must install this to your system"
		einfo "for using the Disk Catalog. The installation process is very"
		einfo "simple, you can find the instructions in"
		einfo "/usr/share/doc/${PF}/README.gz"
	fi
}
