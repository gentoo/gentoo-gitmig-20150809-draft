# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/capi4hylafax/capi4hylafax-01.02.03.13.ebuild,v 1.1 2005/08/11 19:48:28 sbriesen Exp $

inherit eutils versionator

MY_PV="$(get_version_component_range 1-3)"
MY_PP="$(get_version_component_range 4)"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="CAPI4HylaFAX - send/receive faxes via CAPI and AVM Fritz!Cards."
SRC_URI="http://ftp.debian.org/debian/pool/main/c/capi4hylafax/${MY_P/-/_}.orig.tar.gz
		http://ftp.debian.org/debian/pool/main/c/capi4hylafax/${MY_P/-/_}-${MY_PP}.diff.gz"
HOMEPAGE="http://packages.qa.debian.org/c/capi4hylafax.html"

S="${WORKDIR}/${MY_P}"

IUSE="unicode"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND="net-dialup/capi4k-utils
	media-libs/tiff"

RDEPEND="${DEPEND}
	dev-util/dialog"

src_unpack() {
	unpack ${A}
	mv "${S}.orig" "${S}"
	cd "${S}"

	# apply debian patches + update configs
	epatch "${WORKDIR}/${MY_P/-/_}-${MY_PP}.diff"
	libtoolize --copy --force

	# fix location of fax spool
	for i in * debian/* src/scripts/setupconffile; do
		[ -f "${i}" ] && sed -i -e "s:/var/spool/hylafax:/var/spool/fax:" "${i}"
	done

	# fix location of config file
	sed -i -e "s:/etc/hylafax:/var/spool/fax/etc:" src/scripts/setupconffile

	# patch man pages
	sed -i -e "s:/usr/share/doc/capi4hylafax/:/usr/share/doc/${PF}/html/:g" \
		-e "s:c2send:c2faxsend:g" -e "s:c2recv:c2faxrecv:g" \
		-e "s:CAPI4HYLAFAXCONFIG \"1\":C2FAXADDMODEM \"8\":g" \
		-e "s:capi4hylafaxconfig:c2faxaddmodem:g" debian/*.1
	cp -f debian/capi4hylafaxconfig.1 debian/c2faxaddmodem.8

	# if specified, convert all relevant files from latin1 to UTF-8
	if useq unicode; then
		for i in config.faxCAPI; do
			einfo "Converting ${i} to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi

}

src_compile() {
	econf --with-hylafax-spooldir=/var/spool/fax || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# install setup script
	newsbin src/scripts/setupconffile c2faxaddmodem

	# install sample config
	insinto /var/spool/fax/etc
	doins config.faxCAPI

	# install docs
	dodoc AUTHORS ChangeLog Readme_src
	newdoc debian/changelog ChangeLog.debian
	dohtml README.html LIESMICH.html

	# install man pages
	doman debian/c2fax*.[18]

	# install examples
	docinto examples
	dodoc debian/faxsend sample_* fritz_pic.tif GenerateFileMail.pl

	# finally install init-script
	doinitd "${FILESDIR}/capi4hylafax"
}

pkg_postinst() {
	einfo "To use CAPI4HylaFAX:"
	einfo "Make sure that your isdn/capi devices are owned by"
	einfo "the \"uucp\" user (see udev or devfsd config)."
	einfo "Modify /var/spool/fax/etc/config.faxCAPI"
	einfo "to suit your system."
	einfo
	einfo "If you want to use capi4hylafax together with"
	einfo "hylafax, then please emerge net-misc/hylafax"
	einfo
	einfo "Then append the following line to your hylafax"
	einfo "config file (/var/spool/fax/etc/config):"
	einfo "SendFaxCmd:             /usr/bin/c2faxsend"
}
