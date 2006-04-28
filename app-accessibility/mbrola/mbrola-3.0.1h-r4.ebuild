# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/mbrola/mbrola-3.0.1h-r4.ebuild,v 1.2 2006/04/28 19:30:11 josejx Exp $

IUSE=""

S=${WORKDIR}

DESCRIPTION="Speech synthesizer based on the concatenation of diphones. Includes sample voices."
HOMEPAGE="http://tcts.fpms.ac.be/synthesis/mbrola.html"
MY_PV=${PV//./}
TCTS="http://tcts.fpms.ac.be/synthesis"
SRC_URI="${TCTS}/${PN}/bin/pclinux/mbr${MY_PV}.zip
	${TCTS}/mbrola/dba/us1/us1-980512.zip
	${TCTS}/mbrola/dba/us1/us2-980812.zip
	${TCTS}/mbrola/dba/us3/us3-990208.zip
	linguas_de? ( ${TCTS}/mbrola/dba/de1/de1-980227.zip
		${TCTS}/mbrola/dba/de2/de2-990106.zip
		${TCTS}/mbrola/dba/de3/de3-000307.zip
		${TCTS}/mbrola/dba/de4/de4.zip
		${TCTS}/mbrola/dba/de5/de5.zip
		${TCTS}/mbrola/dba/de8/de8.zip )
	linguas_es? ( ${TCTS}/mbrola/dba/es1/es1-980610.zip
		${TCTS}/mbrola/dba/es2/es2-989825.zip
		${TCTS}/mbrola/dba/es4/es4.zip )
	linguas_fr? ( ${TCTS}/mbrola/dba/fr1/fr1-990204.zip
		${TCTS}/mbrola/dba/fr2/fr2-980806.zip
		${TCTS}/mbrola/dba/fr3/fr3-990324.zip
		${TCTS}/mbrola/dba/fr6/fr6-010330.zip )
	linguas_it? ( ${TCTS}/mbrola/dba/it3/it3-010304.zip
		${TCTS}/mbrola/dba/it4/it4-010926.zip )
	linguas_ro? ( ${TCTS}/mbrola/dba/ro1/ro1-980317.zip )"

DEPEND="app-arch/unzip"

RDEPEND=""

SLOT="0"
LICENSE="MBROLA"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 -ppc ~ppc64 ~sparc ~x86"

src_unpack () {
	unpack ${A}

	case ${ARCH} in
		x86|amd64)
			cp mbrola-linux-i386 mbrola || die
			;;
		ppc)
			cp mbrola206a-linux-ppc mbrola || die
			;;
		sparc)
			cp mbrola-SuSElinux-ultra1.dat mbrola || die
			;;
		alpha)
			cp mbrola-linux-alpha mbrola || die
			;;
		*)
			einfo "mbrola binary not available on this architecture.  Still installing voices."
	esac
}

src_install () {
	exeinto /opt/${PN}

	# Take care of main binary
	[[ -f "mbrola" ]] && doexe mbrola

	dodoc readme.txt

	for voice in ??[0-9]; do
		insinto /opt/${PN}/${voice}
		[[ -f "${voice}/license.txt" ]] && doins ${voice}/license.txt
		[[ -f "${voice}/${voice}" ]] && doins ${voice}/${voice}
		[[ -f "${voice}/${voice}mrpa" ]] && doins ${voice}/${voice}mrpa

		if [[ -d "${voice}/TEST" ]]; then
			insinto /opt/${PN}/${voice}/TEST
			doins ${voice}/TEST/*
		fi

		[[ -f "${voice}/${voice}.txt" ]] && dodoc ${voice}/${voice}.txt
	done

	dodir /opt/bin
	dosym /opt/${PN}/mbrola /opt/bin/mbrola
}
