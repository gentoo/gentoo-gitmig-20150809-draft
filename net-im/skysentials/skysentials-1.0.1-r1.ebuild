# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skysentials/skysentials-1.0.1-r1.ebuild,v 1.1 2009/08/20 02:39:20 darkside Exp $

inherit eutils python

DESCRIPTION="Provides some handy Skype features that are lacking in the Linux client (SMS, etc)"
HOMEPAGE="http://www.kolmann.at/philipp/linux/skysentials/"
SRC_URI="http://www.kolmann.at/philipp/linux/skysentials/skysentials-1.0.1.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/skype4py"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-python26.patch"
}

src_install() {
	dodir $(python_get_sitedir)/skysentials || die "dodir failed"
	insinto $(python_get_sitedir)/skysentials
	doins About.py ListSMS.py RegisterPhone.py SendSMS.py TransferCall.py \
		skysentials.py || die "doins failed"
	fperms a+x $(python_get_sitedir)/skysentials/skysentials.py \
		|| die "fperms failed"
	dosym $(python_get_sitedir)/skysentials/skysentials.py \
		/usr/bin/skysentials.py || die "dosym failed"
	dodoc README ChangeLog || die "dodoc failed"
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/skysentials
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/skysentials
}
