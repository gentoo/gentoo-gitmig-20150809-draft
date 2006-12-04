# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.4.2.ebuild,v 1.1 2006/12/04 15:18:48 foser Exp $

inherit eutils libtool autotools

DESCRIPTION="A library for configuring and customizing font access"
HOMEPAGE="http://fontconfig.org/"
SRC_URI="http://fontconfig.org/release/${P}.tar.gz"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc xml"

RDEPEND=">=media-libs/freetype-2.1.4
	!xml? ( >=dev-libs/expat-1.95.3 )
	xml? ( >=dev-libs/libxml2-2.6 )"

DEPEND="${RDEPEND}
	doc? ( app-text/docbook-sgml-utils )"

src_unpack() {

	unpack ${A}

	cd "${S}"
	# add docbook switch so we can disable it
	epatch "${FILESDIR}"/${PN}-2.3.2-docbook.patch

	eautoreconf

	# elibtoolize
	epunt_cxx #74077

}

src_compile() {

	[ "${ARCH}" == "alpha" -a "${CC}" == "ccc" ] && \
		die "Dont compile fontconfig with ccc, it doesnt work very well"

	# disable docs only disables local docs generation, they come with the tarball
	econf $(use_enable doc docs) \
		$(use_enable doc docbook) \
		--localstatedir=/var \
		--with-docdir=/usr/share/doc/${PF} \
		--with-default-fonts=/usr/share/fonts \
		--with-add-fonts=/usr/local/share/fonts,/usr/X11R6/lib/X11/fonts \
		$(use_enable xml libxml2) \
		|| die

	emake -j1 || die

}

src_install() {

	make DESTDIR="${D}" install || die

	insinto /etc/fonts
	doins "${S}"/fonts.conf
	newins "${S}"/fonts.conf fonts.conf.new

	cd "${S}"
	newman doc/fonts-conf.5 fonts-conf.5

	dohtml doc/fontconfig-user.html
	dodoc doc/fontconfig-user.{txt,pdf}

	if use doc; then
		doman doc/Fc*.3
		dohtml doc/fontconfig-devel.html doc
		dohtml -r doc/fontconfig-devel
		dodoc doc/fontconfig-devel.{txt,pdf}
	fi

	dodoc AUTHORS ChangeLog NEWS README

}

pkg_postinst() {

	# Changes should be made to /etc/fonts/local.conf, and as we had
	# too much problems with broken fonts.conf, we force update it ...
	# <azarah@gentoo.org> (11 Dec 2002)
	ewarn "Please make fontconfig configuration changes in /etc/fonts/conf.d/"
	ewarn "and NOT to /etc/fonts/fonts.conf, as it will be replaced!"
	mv -f ${ROOT}/etc/fonts/fonts.conf.new ${ROOT}/etc/fonts/fonts.conf
	rm -f ${ROOT}/etc/fonts/._cfg????_fonts.conf

	if [ "${ROOT}" = "/" ]
	then
		ebegin "Creating global font cache..."
		/usr/bin/fc-cache -s
		eend $?
	fi

}
