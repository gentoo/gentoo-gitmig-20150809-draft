# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/capi4hylafax/capi4hylafax-01.02.03.ebuild,v 1.1 2004/12/02 21:26:14 genstef Exp $

inherit eutils

DESCRIPTION="CAPI4HylaFAX - send/receive faxes via CAPI and AVM Fritz!Cards."
SRC_URI="mirror://debian/pool/main/c/capi4hylafax/capi4hylafax_${PV}.orig.tar.gz
		mirror://debian/pool/main/c/capi4hylafax/capi4hylafax_${PV}-7.diff.gz"
HOMEPAGE="http://packages.qa.debian.org/c/capi4hylafax.html"

IUSE="unicode"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="net-dialup/capi4k-utils
		net-misc/hylafax"

src_unpack() {
	unpack ${A} || die "unpack failed"
	mv ${S}.orig ${S}
	cd ${S}

	epatch ${WORKDIR}/capi4hylafax_${PV}-7.diff

	for i in * debian/* src/scripts/setupconffile; do
		[ -f "${i}" ] && sed -si "s:/var/spool/hylafax:/var/spool/fax:" ${i}
	done

	# patch man pages
	sed -i -e "s:/usr/share/doc/capi4hylafax/:/usr/share/doc/${P}/html/:g" \
		-e "s:c2send:c2faxsend:g" -e "s:c2recv:c2faxrecv:g" \
		-e "s:CAPI4HYLAFAXCONFIG(1):C2FAXADDMODEM(8):g" \
		-e "s:CAPI4HYLAFAXCONFIG \"1\":C2FAXADDMODEM \"8\":g" \
		-e "s:capi4hylafaxconfig:c2faxaddmodem:g" debian/*.1
	cp -f debian/capi4hylafax.1 debian/c2faxaddmodem.8

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
	einstall || die "einstall failed"

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
	dodoc sample_*
	dodoc fritz_pic.tif
	dodoc GenerateFileMail.pl

	# finally install init-script
	exeinto /etc/init.d
	doexe ${FILESDIR}/capi4hylafax
}

pkg_postinst() {
	einfo "To use CAPI4HylaFAX:"
	einfo "Make sure that your isdn/capi devices are owned by"
	einfo "the \"uucp\" user (set in /etc/devfsd.conf)."
	einfo "Modify /var/spool/fax/etc/config.faxCAPI"
	einfo "to suit your system, and append the line"
	einfo "SendFaxCmd:             /usr/bin/c2faxsend"
	einfo "to your HylaFAX config file (/var/spool/fax/etc/config)."
}
