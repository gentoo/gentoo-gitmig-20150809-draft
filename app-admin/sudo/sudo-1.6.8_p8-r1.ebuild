# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.8_p8-r1.ebuild,v 1.1 2005/06/05 20:14:53 taviso Exp $

inherit eutils pam

#
# TODO: Fix support for krb4 and krb5
#

DESCRIPTION="Allows certain users/groups to run commands as root"
HOMEPAGE="http://www.sudo.ws/"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P/_/}.tar.gz"

LICENSE="Sudo"
SLOT="0"
KEYWORDS="~x86"
IUSE="pam skey offensive"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 ) skey? ( >=app-admin/skey-1.1.5-r1 )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A} ; cd ${S}

	# disallow lazy bindings
	epatch ${FILESDIR}/${PN}-1.6.8_p1-suid_fix.patch

	# disallow shellopts variable if user has disabled reset_env.
	epatch ${FILESDIR}/sudo-strip-shellopts.diff

	# compatability fix.
	use skey && epatch ${FILESDIR}/${PN}-skeychallengeargs.diff
}

src_compile() {
	local line ROOTPATH

	# secure_path must be compiled into sudo, so find the current setting
	# of ROOTPATH. This is not perfect, but until it is available as a
	# sudoers setting this will do.
	einfo "Setting secure_path..."

	# why not use grep? variable might be expanded from other variables 
	# declared in that file, and would have to eval the result anyway.
	eval `PS4= bash -x /etc/profile.env 2>&1 | \
		while read -a line; do
			case $line in
				ROOTPATH=*) echo $line; break;;
				*) continue;;
			esac
		done` || ewarn "failed to find secure_path, please report this"

	econf \
		--with-secure-path="/bin:/sbin:/usr/bin:/usr/sbin:${ROOTPATH:-/usr/local/bin}" \
		--with-env-editor \
		`use_with offensive all-insults`\
		`use_with pam` \
		`use_with skey` \
		|| die
	emake || die
}

src_install() {
	einstall || die
	dodoc BUGS CHANGES HISTORY PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*

	use pam && dopamd ${FILESDIR}/sudo

	insinto /etc
	doins ${FILESDIR}/sudoers

	fperms 0440 /etc/sudoers
}

pkg_postinst() {
	use skey && use pam && {
		 ewarn "sudo will not use skey authentication when compiled with"
		 ewarn "pam support. to allow users to authenticate with one time"
		 ewarn "passwords, you should unset the pam USE flag for sudo."
	}
}
