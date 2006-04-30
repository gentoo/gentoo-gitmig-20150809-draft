# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdw/cdw-0.2.3.ebuild,v 1.5 2006/04/30 22:25:36 bazik Exp $

inherit eutils

MY_P=${PN}-${PV/_/-}
DESCRIPTION="gtk2 and ncurses-based console frontend to cdrecord and mkisofs"
HOMEPAGE="http://cdw.sourceforge.net"
SRC_URI="mirror://sourceforge/cdw/${PN}-${PV/_/-}.tar.gz
	mirror://debian/pool/main/c/cdw/${PN}_${PV}-3.diff.gz"

KEYWORDS="~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="encode gtk mysql nls vorbis sqlite"

RDEPEND="virtual/cdrtools
	gtk? ( >=x11-libs/gtk+-2
			>=dev-libs/glib-2 )
	sys-libs/ncurses
	sys-libs/zlib
	vorbis? ( media-libs/libvorbis )
	sqlite? ( dev-db/sqlite )
	mysql? ( dev-db/mysql )
	encode? ( media-sound/lame )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	gtk? ( dev-util/pkgconfig )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${PN}_${PV}-3.diff"
	aclocal && automake -a && autoconf || die "autotools failed"
}

src_compile() {
	local myconf

	use vorbis \
		&& myconf="${myconf} --with-oggenc=/usr/bin/oggenc" \
		|| myconf="${myconf} $(use_with vorbis oggenc)"

	use encode \
		&& myconf="${myconf} --with-lame=/usr/bin/lame" \
		|| myconf="${myconf} $(use_with encode lame)"

	econf \
		--disable-dependency-tracking \
		${myconf} \
		$(use_enable nls) \
		$(use_enable mysql) \
		$(use_enable sqlite) \
		$(use_enable gtk gui) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS THANKS \
		doc/{KNOWN_BUGS,README*,default.conf}

	if use mysql || use sqlite ; then
		insinto /usr/share/${PF}/
		doins doc/cdw.sql || die "doins failed"
	fi

	# clean up the docs installed with make install
	rm -rf "${D}/usr/share/doc/${PN}"
	if use gtk ; then
		make_desktop_entry cdw CDW cdw.png
		doicon pixmaps/cdw.png
	fi
}

pkg_postinst() {
	if use mysql || use sqlite ; then
		echo
		einfo "You have chosen, either by selecting 'USE=mysql' or 'USE=sqlite'"
		einfo "to install Disk Catalog support."
		einfo "You will have a new tool called cdwdic."
		echo
		einfo "The directory /usr/share/${PF}/"
		einfo "contains a cdw.sql file. You must install this to your system"
		einfo "for using the Disk Catalog. The installation process is very"
		einfo "simple, you can find the instructions in"
		einfo "/usr/share/doc/${PF}/README.gz"
	fi
}
