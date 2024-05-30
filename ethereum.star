ethereum_package = import_module(
    "github.com/kurtosis-tech/ethereum-package/main.star@3.0.0"
)

GETH_IMAGE = "ethereum/client-go:v1.14.0"
LIGHTHOUSE_IMAGE = "sigp/lighthouse:v5.1.3"


def run(plan, args):
    ethereum_package.run(
        plan,
        {
            "participants": [
                {
                    # Execution layer (EL)
                    "el_type": "geth",
                    "el_image": GETH_IMAGE,
                    # Consensus layer (CL)
                    "cl_type": "lighthouse",
                    "cl_image": LIGHTHOUSE_IMAGE,
                    "use_separate_vc": True,
                    # Validator parameters
                    "vc_type": "lighthouse",
                    "vc_image": LIGHTHOUSE_IMAGE,
                    # Participant parameters
                    "count": 1,
                }
            ],
            "network_params": {
                # The ethereum package requires the network id to be a string.
                "network_id": str(args["l1_chain_id"]),
                "preregistered_validator_keys_mnemonic": args[
                    "l1_preallocated_mnemonic"
                ],
            },
            "additional_services": args["l1_additional_services"],
        },
    )

#
# ethereum_package = import_module(
#     "github.com/kurtosis-tech/ethereum-package/main.star@3.0.0"
# )
#
# GETH_IMAGE = "ethereum/client-go:v1.14.0"
# LIGHTHOUSE_IMAGE = "sigp/lighthouse:v5.1.3"
#
# def run(plan, args):
#     # Modificar la configuración del participante para añadir los flags necesarios
#     participants = [
#         {
#             # Execution layer (EL)
#             "el_type": "geth",
#             "el_image": GETH_IMAGE,
#             "el_flags": [
#                 "--networkid", str(args["l1_chain_id"]),
#                 "--http",
#                 "--http.addr", "0.0.0.0",
#                 "--http.port", "8545",
#                 "--http.api", "eth,net,web3",
#                 "--http.corsdomain", "*",
#                 "--http.vhosts", "*",
#                 "--rpc.allow-unprotected-txs",
#                 "--rpc.gascap", "0",
#                 "--rpc.txfeecap", "0"
#             ],
#             # Consensus layer (CL)
#             "cl_type": "lighthouse",
#             "cl_image": LIGHTHOUSE_IMAGE,
#             "use_separate_vc": True,
#             # Validator parameters
#             "vc_type": "lighthouse",
#             "vc_image": LIGHTHOUSE_IMAGE,
#             # Participant parameters
#             "count": 1,
#         }
#     ]
#
#     # Pasar la configuración modificada a ethereum_package.run
#     ethereum_package.run(
#         plan,
#         {
#             "participants": participants,
#             "network_params": {
#                 # The ethereum package requires the network id to be a string.
#                 "network_id": str(args["l1_chain_id"]),
#                 "preregistered_validator_keys_mnemonic": args[
#                     "l1_preallocated_mnemonic"
#                 ],
#             },
#             "additional_services": args["l1_additional_services"],
#         },
#     )
