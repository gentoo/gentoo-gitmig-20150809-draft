# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/teamspeak2-client-bin/teamspeak2-client-bin-2.0.32.60-r2.ebuild,v 1.3 2004/03/04 18:15:12 vapier Exp $

MY_PV=rc2_2032
DESCRIPTION="The Teamspeak Voice Communication Tool"
HOMEPAGE="http://www.teamspeak.org/"
SRC_URI="ftp://teamspeak.krawall.de/releases/ts2_client_${MY_PV}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="kde"

# Note: ts2 client comes with its own speex library, so no need to
# depend on it
DEPEND="virtual/x11
	virtual/glibc
	kde? ( >=kde-base/kdelibs-3.1.0 )"

S=${WORKDIR}/ts2_client_${MY_PV}/setup.data/image

src_install() {
	local dir="/opt/teamspeak2-client"
	dodir ${dir}

	# Edit the Teamspeak startscript to match our install directory
	sed -i -e "s:%installdir%:${dir}:g" TeamSpeak

	if use kde ; then
		# Install a teamspeak.protocol file for kde/konqueror to accept
		# teamspeak:// links
		insinto $(kde-config --prefix)/share/services/
		doins ${FILESDIR}/teamspeak.protocol
	fi

	# The next three are removed after the operation so that they are not
	# copied into the install directory
	dobin TeamSpeak && rm TeamSpeak
	newdoc Readme.txt README && rm Readme.txt
	dohtml -r manual/* && rm -rf manual

	# A symlink is created so that Help -> Read Manual still works
	dosym /usr/share/doc/${PF}/html ${dir}/manual

	# All regular files except the executables are made non executable
	find -type f -not \( -name "TeamSpeak.bin" -or -name "*.so*" -or \
		-name "tsControl" \) -exec chmod -x {} \;

	#Install the teamspeak icon.
	insinto /usr/share/pixmaps
	newins ${S}/icon.xpm ${S}/teamspeak.xpm

	cp -r * ${D}/${dir} || die "cp failed"
}

pkg_postinst() {
	einfo "Note: If you just upgraded from a version less than 2.0.32.60-r1,"
	einfo "your users' config files will incorrectly point to non-existant"
	einfo "soundfiles because they've been moved from their old location."
	einfo "You may want to perform the following commands:"
	einfo "# mkdir /usr/share/teamspeak2-client"
	einfo "# ln -s ${dir}/sounds /usr/share/teamspeak2-client/sounds"
	einfo "This way, each user won't have to modify their config files to"
	einfo "reflect this move."
}
