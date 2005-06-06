# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sudo/sudo-1.6.8_p8-r2.ebuild,v 1.9 2005/06/06 14:22:31 taviso Exp $

inherit eutils pam

# TODO: Fix support for krb4 and krb5

DESCRIPTION="Allows certain users/groups to run commands as root"
HOMEPAGE="http://www.sudo.ws/"
SRC_URI="ftp://ftp.sudo.ws/pub/sudo/${P/_/}.tar.gz"
LICENSE="Sudo"
SLOT="0"
KEYWORDS="~x86"
IUSE="pam skey offensive ldap"

DEPEND="pam? ( >=sys-libs/pam-0.73-r1 )
	skey? ( >=app-admin/skey-1.1.5-r1 )
	ldap? ( >=net-nds/openldap-2.1.30-r1 )"
S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}; cd ${S}

	# compatability fix.
	use skey && epatch ${FILESDIR}/${PN}-skeychallengeargs.diff

	# additional variables to disallow, should user disable env_reset.

	# NOTE: this is not a supported mode of operation, these variables
	#       are added to the blacklist as a convenience to administrators
	#       who fail to heed the warnings of allowing untrusted users
	#       to access sudo.
	#
	#       there is *no possible way* to foresee all attack vectors in
	#       all possible applications that could potentially be used via
	#       sudo, these settings will just delay the inevitable.
	#
	#       that said, I will accept suggestions for variables that can
	#       be misused in _common_ interpreters or libraries, such as 
	#       perl, bash, python, ruby, etc., in the hope of dissuading
	#       a casual attacker.

	einfo "blacklisting variables..."
	sudo_bad_var SHELLOPTS            # bash, change shoptions.
	sudo_bad_var PERLIO_DEBUG         # perl, write debug to file.
	sudo_bad_var PERL5LIB             # perl, change search path.
	sudo_bad_var PERL_HASH_SEED       # perl, change seed.
	sudo_bad_var PERL_HASH_SEED_DEBUG # perl, disclose seed.
	sudo_bad_var PERL_SIGNALS         # perl, use deferred signals.
	sudo_bad_var FIGNORE              # sh, set glob mask.
	sudo_bad_var FPATH                # sh, search path for functions.
	sudo_bad_var PS3                  # sh, prompt for select.
	sudo_bad_var GLOBIGNORE           # bash, glob paterns to ignore.
	sudo_bad_var PERL5OPT             # perl, set options
	einfo "...done."
}

src_compile() {
	local line ROOTPATH

	# secure_path must be compiled into sudo, so find the current setting
	# of ROOTPATH. This is not perfect, but until it is available as a
	# sudoers setting this will do.
	ebegin "setting secure_path..."

	# why not use grep? variable might be expanded from other variables 
	# declared in that file, and would have to eval the result anyway.
	# cannot just source the file, could override any variables already set.
	eval `PS4= bash -x /etc/profile.env 2>&1 | \
		while read line; do
			case $line in
				ROOTPATH=*) echo $line; break;;
				*) continue;;
			esac
		done` || ewarn "failed to find secure_path, please report this"
	eend $?

	econf --with-secure-path="/bin:/sbin:/usr/bin:/usr/sbin:${ROOTPATH:-/usr/local/bin}" --with-env-editor \
		`use_with offensive insults` \
		`use_with offensive all-insults` \
		`use_with pam` \
		`use_with skey` \
		`use_with ldap` || die

	# disallow lazy bindings
	emake SUDO_LDFLAGS="-Wl,-z,now" || die
}

src_install() {
	einstall || die
	dodoc BUGS CHANGES HISTORY PORTING README RUNSON TODO \
		TROUBLESHOOTING UPGRADE sample.*

	use pam && newpamd ${FILESDIR}/sudo-${PV} sudo

	insinto /etc
	doins ${FILESDIR}/sudoers

	fperms 0440 /etc/sudoers
}

sudo_bad_var() {
	local target='env.c' marker='\*initial_badenv_table\[\]'

	# add $1 to initial_badenv_table[].
	ebegin "	$1"
		sed -i 's#\(^.*'${marker}'.*$\)#\1\n\t"'${1}'",#' ${S}/${target}
	eend $?
}

pkg_postinst() {
	use skey && use pam && {
		 ewarn "sudo will not use skey authentication when compiled with"
		 ewarn "pam support. to allow users to authenticate with one time"
		 ewarn "passwords, you should unset the pam USE flag for sudo."
	}
}
