# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plone4artistssite/plone4artistssite-1.0.ebuild,v 1.1 2008/03/21 06:37:15 tupone Exp $

inherit zproduct

MY_PN="Plone4ArtistsSite"

DESCRIPTION="Plone product exposing the entire suite of Plone4Artist."
HOMEPAGE="http://plone4artists.org/products/plone4artistssite/"
SRC_URI="${HOMEPAGE}releases/${PV}/${MY_PN}-bundle-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-zope/zope-2.9.8
	>=net-zope/plone-2.5.3
	<net-zope/plone-3"

ZPROD_LIST="CMFonFive
	Calendaring
	ContentLicensing
	Five
	Plone4ArtistsDeps
	Plone4ArtistsSite
	PloneContentRating
	PloneFlashUpload
	basesyndication
	easycommenting
	fatsyndication"
